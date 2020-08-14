import Foundation

public protocol FlowAssembly {
    var inputHandlers: [FlowInputHandler] { get }
    var action: FlowAction { get }
    var context: Storable? { get }
}
