import Foundation

public class CancelOperationFlowAssembly: FlowAssembly {

    public let initialHandlerId: String
    public let inputHandlers: [String: FlowInputHandler]
    public let action: FlowAction
    public let context: Any?

    public init() {
        initialHandlerId = ""
        inputHandlers = [:]
        action = CancelOperationAction()
        context = nil
    }

}
