import Foundation

public struct CommandHandler {
    public var command: Command
    public var description: String
    public var flowAssembly: FlowAssembly

    public init(
        command: Command,
        description: String,
        flowAssembly: FlowAssembly
    ) {
        self.command = command
        self.description = description
        self.flowAssembly = flowAssembly
    }
}
