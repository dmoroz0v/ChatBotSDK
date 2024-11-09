import Foundation

public protocol FlowAction {
    func execute(chat: Chat, user: User) async -> [String]
}
