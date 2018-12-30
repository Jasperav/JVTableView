public protocol ChangeableValues: Changeable {
    associatedtype T: Equatable
    
    var currentValue: T { get set }
    var oldValue: (() -> (T))? { get }
}

public extension ChangeableValues {
    func determineHasBeenChanged() -> Bool {
        return currentValue != oldValue!()
    }
    
    func reset() {
        
        // If you want to reset the current row, it should and must have an oldValue.
        currentValue = oldValue!()
    }
}
