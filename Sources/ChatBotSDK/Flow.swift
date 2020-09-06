import Foundation

final class Flow: Storable {
    private let initInputHandlerId: String
    private let inputHandlers: [String: FlowInputHandler]
    private let action: FlowAction
    private let context: Storable?

    struct Result {
        public var finished: Bool
        public var texts: [String]
        public var keyboard: ReplyKeyboardMarkup? = nil

        public init(
            finished: Bool,
            texts: [String],
            keyboard: ReplyKeyboardMarkup? = nil
        ) {
            self.finished = finished
            self.texts = texts
            self.keyboard = keyboard
        }
    }

    private var currentInputId: String = ""

    init(
        initInputHandlerId: String,
        inputHandlers: [String: FlowInputHandler],
        action: FlowAction,
        context: Storable?
    ) {
        self.initInputHandlerId = initInputHandlerId
        self.inputHandlers = inputHandlers
        self.action = action
        self.context = context
    }

    func handleUpdate(userId: Int64, text: String) -> Result {
        var inputMarkup: FlowInputHandlerMarkup?
        if !currentInputId.isEmpty,
           let inputHandler = inputHandlers[currentInputId] {
            let result = inputHandler.handle(userId: userId, text: text)
            switch result {
            case .continue(let id):
                currentInputId = id
            case .end:
                currentInputId = ""
            case .stay(let markup):
                inputMarkup = markup
            }
        } else {
            currentInputId = initInputHandlerId
        }

        if let inputMarkup = inputMarkup {
            return Result(finished: inputMarkup.interrupt,
                          texts: inputMarkup.texts,
                          keyboard: inputMarkup.keyboard)
        } else if !currentInputId.isEmpty,
           let inputHandler = inputHandlers[currentInputId] {
            let inputMarkup = inputHandler.start(userId: userId)
            return Result(finished: inputMarkup.interrupt,
                          texts: inputMarkup.texts,
                          keyboard: inputMarkup.keyboard)
        } else {
            return Result(finished: true,
                          texts: action.execute(userId: userId),
                          keyboard: nil)
        }
    }

    func store() -> StorableContainer {
        let container = StorableContainer()

        container.setString(
            value: currentInputId,
            key: "currentInputId"
        )

        if let inputHandler = inputHandlers[currentInputId] {
            container.setContainer(
                container: inputHandler.store(),
                key: "currentInputHandler"
            )
        }

        if let contextContainer = context?.store() {
            container.setContainer(
                container: contextContainer,
                key: "context"
            )
        }

        return container
    }

    func restore(container: StorableContainer) {
        if let currentInputId = container.stringValue(key: "currentInputId") {
            self.currentInputId = currentInputId
        }

        if let inputHandlerContainer = container.container(key: "currentInputHandler") {
            inputHandlers[currentInputId]?.restore(container: inputHandlerContainer)
        }

        if let contextContainer = container.container(key: "context") {
            context?.restore(container: contextContainer)
        }
    }
}
