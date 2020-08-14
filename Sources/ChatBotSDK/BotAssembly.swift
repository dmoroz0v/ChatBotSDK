import Foundation

public protocol BotAssembly {
    var commandsHandlers: [CommandHandler] { get }
}
