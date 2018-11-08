// TODO: Better naming...
// This is split up in two protocols because of the generic constraints.
public protocol Changeable: AnyObject {
    var hasChanged: ((Bool) -> ())? { get set }
    
    func determineHasBeenChanged() -> Bool
    func reset()
}
