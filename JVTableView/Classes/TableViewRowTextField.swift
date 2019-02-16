import UIKit
import JVChangeableValue
import JVTextField
import JVInputValidator

open class TableViewRowTextField: TableViewRow, ChangeableValues, InputValidateable {
    
    public static var textFieldInitializer: TextFieldInitializer!
    
    public var oldValue = ""
    public var currentValue: String
    
    public var inputValidator = InputValidator(validationState: .valid)
    
    // Sends back if the currentValue == oldValue
    public var hasChanged: ((Bool) -> ())?
    public var didReturn: (() -> ())?
    
    let validationBlockUserInput: ((String) -> (Bool))
    private let validationToChangeValidationState: ((String) -> (Bool))
    private let keyboardReturnType: UIReturnKeyType
    private let textFieldInitializer: TextFieldInitializer
    private let placeholderText: String
    
    public init(identifier: String,
                placeholderText: String,
                validationBlockUserInput: @escaping ((String) -> (Bool)),
                validationToChangeValidationState: @escaping ((String) -> (Bool)),
                keyboardReturnType: UIReturnKeyType = .done,
                textFieldInitializer: TextFieldInitializer = TableViewRowTextField.textFieldInitializer,
                oldValue: String = "") {
        self.oldValue = oldValue
        self.validationBlockUserInput = validationBlockUserInput
        self.validationToChangeValidationState = validationToChangeValidationState
        self.placeholderText = placeholderText
        self.keyboardReturnType = keyboardReturnType
        self.textFieldInitializer = textFieldInitializer
        currentValue = oldValue
        
        super.init(cell: JVTableViewStdCell.textField,
                   identifier: identifier)
    }
    
    open override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellTextField
        
        _cell.oldValue = oldValue
        
        _cell.textField.update(textFieldInitializer: textFieldInitializer)
        _cell.textField.validationBlockUserInput = validationBlockUserInput
        _cell.textField.validationToChangeValidationState = validationToChangeValidationState
        _cell.textField.oldValue = oldValue
        _cell.textField.placeholder = placeholderText
        _cell.textField.text = currentValue
        _cell.textField.accessibilityIdentifier = identifier
        _cell.textField.returnKeyType = keyboardReturnType
        
        inputValidator.update(state: _cell.textField.inputValidator.validationState)
        
        _cell.textField.hasChanged = { [unowned self] (hasChanged) in
            self.currentValue = _cell.currentValue
            self.hasChanged!(hasChanged)
        }
        
        _cell.textField.didReturn = { [unowned self] in
            self.didReturn?()
        }
        
        _cell.textField.inputValidator.changedValidationState = { [unowned self] (state) in
            self.inputValidator.update(state: state)
        }
    }
    
    open override func determineUpdateType() -> TableViewRowUpdateType {
        return .text(currentValue)
    }
}
