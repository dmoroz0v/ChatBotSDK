import Foundation

public protocol FlowAction {
    func execute(userId: Int64) async -> [String]
}
