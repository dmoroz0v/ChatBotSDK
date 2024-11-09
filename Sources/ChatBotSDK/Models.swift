import Foundation

public struct User {
    public var id: Int64
    public var username: String?

    public init(id: Int64, username: String?) {
        self.id = id
        self.username = username
    }
}

public struct Chat {
    public var id: Int64

    public init(id: Int64) {
        self.id = id
    }
}
