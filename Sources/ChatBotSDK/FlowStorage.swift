import Foundation

public protocol FlowStorage {
    func save(value: String?, userId: Int64)
    func fetch(userId: Int64) -> String?
}
