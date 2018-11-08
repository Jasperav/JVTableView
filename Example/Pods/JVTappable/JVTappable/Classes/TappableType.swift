public protocol TappableType {
    associatedtype T
    var tapped: ((_ value: T) -> ())? { get }
}
