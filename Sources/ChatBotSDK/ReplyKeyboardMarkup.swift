import Foundation

public struct ReplyKeyboardMarkup {
    public var keyboard: [[KeyboardButton]]
    public var resizeKeyboard: Bool
    public var oneTimeKeyboard: Bool
}

public struct KeyboardButton {
    public var text: String
}
