import Foundation

public struct Command: Codable, Equatable {
    public var value: String

    public init(value: String) {
        self.value = value
    }
}
