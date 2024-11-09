public enum FlowInputHandlerResult {
    case `continue`(id: String)
    case end
    case stay(markup: FlowInputHandlerMarkup)
}

public protocol FlowInputHandler {
    func start(chat: Chat, user: User) -> FlowInputHandlerMarkup
    func handle(chat: Chat, user: User, text: String) -> FlowInputHandlerResult
}
