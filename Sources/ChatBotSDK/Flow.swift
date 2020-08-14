import Foundation

final class Flow: Storable {
    private let inputHandlers: [FlowInputHandler]
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

    private var inputStep: Int = -1

    init(
        inputHandlers: [FlowInputHandler],
        action: FlowAction,
        context: Storable?
    ) {
        self.inputHandlers = inputHandlers
        self.action = action
        self.context = context
    }

    func handleUpdate(userId: Int64, text: String) -> Result {
        if (inputStep >= 0) {
            inputHandlers[inputStep].handle(userId: userId, text: text)
        }

        inputStep += 1

        if inputStep < inputHandlers.count {
            let inputMarkup = inputHandlers[inputStep].markup(userId: userId)
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

        container.setInt(value: inputStep, key: "inputStep")

        if let contextContainer = context?.store() {
            container.setContainer(container: contextContainer, key: "context")
        }

        return container
    }

    func restore(container: StorableContainer) {
        if let inputStep = container.intValue(key: "inputStep") {
            self.inputStep = inputStep
        }

        if let contextContainer = container.container(key: "context") {
            context?.restore(container: contextContainer)
        }
    }
}
