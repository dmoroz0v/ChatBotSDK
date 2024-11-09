import Foundation

public class CancelOperationAction: FlowAction {

    public func execute(chat: Chat, user: User) -> [String] {
        return ["Current operation was cancelled"]
    }
}
