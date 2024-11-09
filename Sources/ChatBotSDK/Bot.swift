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
    private let unexpectedResult: Result?

    private var flowControllers: [Int64: FlowController] = [:]

    public init(
        commandsHandlers: [CommandHandler],
        unexpectedResult: Result?
    ) {
        self.commandsHandlers = commandsHandlers
        self.unexpectedResult = unexpectedResult
    }

    public func update(chat: Chat, user: User, text: String) async -> Result? {
        let flowController: FlowController

        if text.hasPrefix("/"), let commandValue = text.split(separator: "@").first {
            flowController = FlowController(
                chat: chat,
                user: user,
                commandsHandlers: commandsHandlers
            )
            flowControllers[user.id] = flowController
            flowController.start(command: Command(value: String(commandValue)))
        } else if let fc = flowControllers[user.id] {
            flowController = fc
        } else {
            return unexpectedResult
        }

        let result = await flowController.handleUpdate(text: text)

        if result.finished {
            flowControllers[user.id] = nil
        }

        return Result(texts: result.texts, keyboard: result.keyboard)
    }
}
