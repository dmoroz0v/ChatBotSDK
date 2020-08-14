public protocol FlowInputHandler {
    func markup(userId: Int64) -> FlowInputHandlerMarkup
    func handle(userId: Int64, text: String)
}
