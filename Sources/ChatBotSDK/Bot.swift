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

    private let commandsHandlers: [CommandHandler]

    private var flowControllers: [Int64: FlowController] = [:]

    public init(
        commandsHandlers: [CommandHandler]
    ) {
        self.commandsHandlers = commandsHandlers
    }

    public func update(chatId: Int64, userId: Int64, text: String) async -> Result {
        let flowController: FlowController

        if text.hasPrefix("/") {
            flowController = FlowController(userId: userId, commandsHandlers: commandsHandlers)
            flowControllers[userId] = flowController
            flowController.start(command: Command(value: text))
        } else if let fc = flowControllers[userId] {
            flowController = fc
        } else {
            return Result(texts: ["Unexpected error"], keyboard: nil)
        }

        let result = await flowController.handleUpdate(text: text)

        return Result(texts: result.texts, keyboard: result.keyboard)
    }
}
