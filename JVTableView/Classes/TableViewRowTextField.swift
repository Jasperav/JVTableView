import UIKit

open class TableViewRowTextField: TableViewRow, ChangeableValues {
    
    public let placeholderText: String
    public var oldValue: (() -> (String))?
    public var currentValue: String
    
    // Sends back if the currentValue == oldValue
    public var hasChanged: ((Bool) -> ())?
    public var validate: ((String) -> (Bool))
    public var keyboardReturnType = UIReturnKeyType.done
    public var didReturn: (() -> ())?
    
    public init(identifier: String,
                placeholderText: String,
                validate: @escaping ((String) -> (Bool)),
                oldValue: (() -> (String))? = nil) {
        self.oldValue = oldValue
        self.validate = validate
        self.placeholderText = placeholderText
        currentValue = oldValue?() ?? ""
        
        super.init(cell: JVTableViewStdCell.textField,
                   identifier: identifier)
    }
    
    open override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellTextField
        
        _cell.validate = validate
        _cell.oldValue = oldValue
        _cell.textField.placeholder = placeholderText
        _cell.textField.text = currentValue
        _cell.textField.accessibilityIdentifier = identifier
        _cell.textField.returnKeyType = keyboardReturnType
        
        _cell.hasChanged = { [unowned self] (hasChanged) in
            self.currentValue = _cell.currentValue
            self.hasChanged?(hasChanged)
        }
        
        _cell.didReturn = { [unowned self] in
            self.didReturn?()
        }
    }
}
