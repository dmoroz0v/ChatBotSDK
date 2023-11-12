import Foundation

public protocol FlowAssembly {
    var initialHandlerId: String { get }
    var inputHandlers: [String: FlowInputHandler] { get }
    var action: FlowAction { get }
    var context: Any? { get }
}
