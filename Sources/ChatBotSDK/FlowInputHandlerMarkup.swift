import Foundation

public struct FlowInputHandlerMarkup {
    public var texts: [String]
    public var keyboard: ReplyKeyboardMarkup? = nil
    public var interrupt: Bool = false

    public init(
        texts: [String],
        keyboard: ReplyKeyboardMarkup? = nil,
        interrupt: Bool = false
    ) {
        self.texts = texts
        self.keyboard = keyboard
        self.interrupt = interrupt
    }
}
