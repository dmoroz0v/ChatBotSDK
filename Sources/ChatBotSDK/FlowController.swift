import Foundation

final class FlowController {

    private struct State: Codable {
        let command: Command
        let container: StorableContainer
    }

    private let flowStorage: FlowStorage
    private let userId: Int64
    private let commandsHandlers: [CommandHandler]

    private var flow: Flow? = nil
    private var command: Command? = nil

    init(
        flowStorage: FlowStorage,
        userId: Int64,
        commandsHandlers: [CommandHandler]
    ) {
        self.flowStorage = flowStorage
        self.userId = userId
        self.commandsHandlers = commandsHandlers
    }

    func start(command: Command) {
        let commandHandler = commandsHandlers.first { $0.command == command }
        if let commandHandler = commandHandler {
            let flowAssembly = commandHandler.flowAssembly
            flow = Flow(
                inputHandlers: flowAssembly.inputHandlers,
                action: flowAssembly.action,
                context: flowAssembly.context
            )
            self.command = command
        }
    }

    func restore() {
        let flowState = flowStorage.fetch(userId: userId)
        if let flowState = flowState, let data = flowState.data(using: .utf8) {
            let state = try? JSONDecoder().decode(State.self, from: data)
            if let state = state {
                let commandHandler = commandsHandlers.first { $0.command == state.command }
                if let commandHandler = commandHandler {
                    let flowAssembly = commandHandler.flowAssembly
                    flow = Flow(
                        inputHandlers: flowAssembly.inputHandlers,
                        action: flowAssembly.action,
                        context: flowAssembly.context
                    )
                    flow?.restore(container: state.container)
                    command = state.command
                }
            }
        }
    }

    func handleUpdate(text: String) -> Flow.Result {
        if let flow = flow {
            return flow.handleUpdate(userId: userId, text: text)
        } else {
            return Flow.Result(
                finished: true,
                texts: ["Unexpected Error"],
                keyboard: nil
            )
        }
    }

    func store() {
        if let command = command, let flow = flow {
            let state = State(command: command, container: flow.store())
            if let data = try? JSONEncoder().encode(state),
               let flowState = String(data: data, encoding: .utf8) {
                flowStorage.save(value: flowState, userId: userId)
            }
        }
    }

    func clear() {
        flowStorage.save(value: nil, userId: userId)
    }
}
