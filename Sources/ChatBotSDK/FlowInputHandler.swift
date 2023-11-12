public enum FlowInputHandlerResult {
    case `continue`(id: String)
    case end
    case stay(markup: FlowInputHandlerMarkup)
}

public protocol FlowInputHandler {
    func start(userId: Int64) -> FlowInputHandlerMarkup
    func handle(userId: Int64, text: String) -> FlowInputHandlerResult
}
