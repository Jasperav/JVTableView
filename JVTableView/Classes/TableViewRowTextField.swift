import UIKit
import JVChangeableValue
import JVTextField

open class TableViewRowTextField: TableViewRow, ChangeableValues {
    
    public static var textFieldInitializer: TextFieldInitializer!
    
    public let placeholderText: String
    public var oldValue: (() -> (String))?
    public var currentValue: String
    
    // Sends back if the currentValue == oldValue
    public var hasChanged: ((Bool) -> ())?
    public var validate: ((String) -> (Bool))
    public var keyboardReturnType = UIReturnKeyType.done
    public var didReturn: (() -> ())?
    public var textFieldInitializer: TextFieldInitializer!
    
    public init(identifier: String,
                placeholderText: String,
                validate: @escaping ((String) -> (Bool)),
                textFieldInitializer: TextFieldInitializer = TableViewRowTextField.textFieldInitializer,
                oldValue: (() -> (String))? = nil) {
        self.oldValue = oldValue
        self.validate = validate
        self.placeholderText = placeholderText
        currentValue = oldValue?() ?? ""
        self.textFieldInitializer = textFieldInitializer
        
        super.init(cell: JVTableViewStdCell.textField,
                   identifier: identifier)
    }
    
    open override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellTextField
        
        _cell.oldValue = oldValue
        
        _cell.textField.update(textFieldInitializer: textFieldInitializer)
        _cell.textField.validate = validate
        _cell.textField.oldValue = oldValue
        _cell.textField.placeholder = placeholderText
        _cell.textField.text = currentValue
        _cell.textField.accessibilityIdentifier = identifier
        _cell.textField.returnKeyType = keyboardReturnType
        
        _cell.textField.hasChanged = { [unowned self] (hasChanged) in
            self.currentValue = _cell.currentValue
            self.hasChanged?(hasChanged)
        }
        
        _cell.textField.didReturn = { [unowned self] in
            self.didReturn?()
        }
    }
}
