import Foundation

public class CancelOperationAction: FlowAction {

    public func execute(userId: Int64) -> [String] {
        return ["Current operation was cancelled"]
    }
}
