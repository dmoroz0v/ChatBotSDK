import Foundation

public extension FileManager {
    final class ChatBotSDK {
        public static var instance: ChatBotSDK!

        public let documentsUrl: URL

        public init(documentsUrl: URL) {
            self.documentsUrl = documentsUrl
        }
    }
}
