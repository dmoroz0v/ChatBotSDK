import Foundation

public struct ReplyKeyboardMarkup {
    public var keyboard: [[KeyboardButton]]
    public var resizeKeyboard: Bool
    public var oneTimeKeyboard: Bool

    public init(
        keyboard: [[KeyboardButton]],
        resizeKeyboard: Bool,
        oneTimeKeyboard: Bool
    ) {
        self.keyboard = keyboard
        self.resizeKeyboard = resizeKeyboard
        self.oneTimeKeyboard = oneTimeKeyboard
    }
}

public struct KeyboardButton {
    public var text: String

    public init(text: String) {
        self.text = text
    }
}
