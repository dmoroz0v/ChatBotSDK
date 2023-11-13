import Foundation

final class FlowController {

    private let userId: Int64
    private let commandsHandlers: [CommandHandler]

    private var flow: Flow? = nil
    private var command: Command? = nil

    init(
        userId: Int64,
        commandsHandlers: [CommandHandler]
    ) {
        self.userId = userId
        self.commandsHandlers = commandsHandlers
    }

    func start(command: Command) {
        var commandHandler = commandsHandlers.first { $0.command == command }
        if commandHandler == nil && command == Command(value: "/help") {
            commandHandler = CommandHandler(
                command: Command(value: "/help"),
                description: "",
                flowAssembly: HelpOperationFlowAssembly(
                    commandsHandlers: commandsHandlers
                )
            )
        }
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
            return await flow.handleUpdate(userId: userId, text: text)
        } else {
            return Flow.Result(
                finished: true,
                texts: ["Unexpected Error"],
                keyboard: nil
            )
        }
    }
}
