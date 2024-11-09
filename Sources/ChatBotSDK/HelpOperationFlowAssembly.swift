import Foundation

final class HelpOperationAction: FlowAction {

    private let commandsHandlers: [CommandHandler]

    init(commandsHandlers: [CommandHandler]) {
        self.commandsHandlers = commandsHandlers
    }

    func execute(chat: Chat, user: User) -> [String] {
        let result = commandsHandlers.map {
            $0.command.value + " - " + $0.description
        }
        return [result.joined(separator: "\n")]
    }
}

final class HelpOperationFlowAssembly: FlowAssembly {

    let initialHandlerId: String
    let inputHandlers: [String: FlowInputHandler]
    let action: FlowAction
    let context: Any?

    init(commandsHandlers: [CommandHandler]) {
        initialHandlerId = ""
        inputHandlers = [:]
        action = HelpOperationAction(commandsHandlers: commandsHandlers)
        context = nil
    }

}
