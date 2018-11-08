public protocol Tappable {
    var tapped: (() -> ())? { get }
}
