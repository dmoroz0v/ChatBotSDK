import Foundation

final class FlowController {

    private let chat: Chat
    private let user: User
    private let commandsHandlers: [CommandHandler]

    private var flow: Flow? = nil
    private var command: Command? = nil

    init(
        chat: Chat,
        user: User,
        commandsHandlers: [CommandHandler]
    ) {
        self.chat = chat
        self.user = user

        var commandsHandlers = commandsHandlers

        commandsHandlers.append(
            CommandHandler(command: Command(value: "/cancel"),
                           description: "Cancel current operation",
                           flowAssembly: CancelOperationFlowAssembly()))

        commandsHandlers.append(
            CommandHandler(command: Command(value: "/help"),
                           description: "",
                           flowAssembly: HelpOperationFlowAssembly(
                            commandsHandlers: commandsHandlers
                        )))

        self.commandsHandlers = commandsHandlers
    }

    func start(command: Command) {
        var commandHandler = commandsHandlers.first { $0.command == command }
        if let commandHandler = commandHandler {
            let flowAssembly = commandHandler.flowAssembly
            flow = Flow(
                initInputHandlerId: flowAssembly.initialHandlerId,
                inputHandlers: flowAssembly.inputHandlers,
                action: flowAssembly.action,
                context: flowAssembly.context
            )
            self.command = command
        }
    }

    func handleUpdate(text: String) async -> Flow.Result {
        if let flow = flow {
            return await flow.handleUpdate(chat: chat, user: user, text: text)
        } else {
            return Flow.Result(
                finished: true,
                texts: ["Unexpected Error"],
                keyboard: nil
            )
        }
    }
}
