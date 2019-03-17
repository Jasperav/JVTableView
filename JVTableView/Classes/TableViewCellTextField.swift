import UIKit
import JVConstraintEdges
import JVChangeableValue
import JVTextField
import JVTableViewCellLayoutCreator

open class TableViewCellTextField: TableViewCell, ChangeableValues {
    
    public let textField = JVTextField()
    
    public var currentValue = ""
    public var oldValue = ""
    public var hasChanged: ((Bool) -> ())?
    public var didReturn: (() -> ())?
    
    open override func setup() {
        TableViewCellLayoutCreator.create(toCell: self, middleView: textField)
        
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
    }
}
