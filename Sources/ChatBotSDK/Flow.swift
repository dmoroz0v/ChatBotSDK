import Foundation

final class Flow {
    private let initInputHandlerId: String
    private let inputHandlers: [String: FlowInputHandler]
    private let action: FlowAction
    private let context: Any?

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
        context: Any?
    ) {
        self.initInputHandlerId = initInputHandlerId
        self.inputHandlers = inputHandlers
        self.action = action
        self.context = context
    }

    func handleUpdate(chat: Chat, user: User, text: String) async -> Result {
        var inputMarkup: FlowInputHandlerMarkup?
        if !currentInputId.isEmpty,
           let inputHandler = inputHandlers[currentInputId] {
            let result = inputHandler.handle(chat: chat, user: user, text: text)
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
            let inputMarkup = inputHandler.start(chat: chat, user: user)
            return Result(finished: inputMarkup.interrupt,
                          texts: inputMarkup.texts,
                          keyboard: inputMarkup.keyboard)
        } else {
            return Result(finished: true,
                          texts: await action.execute(chat: chat, user: user),
                          keyboard: nil)
        }
    }
}
