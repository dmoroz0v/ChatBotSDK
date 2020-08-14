import Foundation

public class CancelOperationFlowAssembly: FlowAssembly {

    public let inputHandlers: [FlowInputHandler]
    public let action: FlowAction
    public let context: Storable?

    public init() {
        inputHandlers = []
        action = CancelOperationAction()
        context = nil
    }

}
