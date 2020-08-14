import Foundation

public final class Bot {

    public struct Result {
        public var texts: [String]
        public var keyboard: ReplyKeyboardMarkup?

        public init(
            texts: [String],
            keyboard: ReplyKeyboardMarkup?
        ) {
            self.texts = texts
            self.keyboard = keyboard
        }
    }

    private let flowStorage: FlowStorage
    private let commandsHandlers: [CommandHandler]

    public init(
        flowStorage: FlowStorage,
        commandsHandlers: [CommandHandler]
    ) {
        self.flowStorage = flowStorage
        self.commandsHandlers = commandsHandlers
    }

    public func update(chatId: Int64, userId: Int64, text: String) -> Result {
        let flowController = FlowController(flowStorage: flowStorage, userId: userId, commandsHandlers: commandsHandlers)

        if text.hasPrefix("/") {
            flowController.start(command: Command(value: text))
        } else {
            flowController.restore()
        }

        let result = flowController.handleUpdate(text: text)

        if result.finished {
            flowController.clear()
        } else {
            flowController.store()
        }

        return Result(texts: result.texts, keyboard: result.keyboard)
    }
}
