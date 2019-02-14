import UIKit
import JVConstraintEdges
import JVChangeableValue
import JVTextField

open class TableViewCellTextField: TableViewCell, ChangeableValues {
    
    public let textField = JVTextField()
    
    public var currentValue = ""
    public var oldValue = ""
    public var hasChanged: ((Bool) -> ())?
    public var didReturn: (() -> ())?
    
    open override func setup() {
        assert(textField.superview == nil)
        
        textField.fill(toSuperview: contentView, edges: TableViewRow.edges)
        
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
    }
}
