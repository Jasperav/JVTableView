import UIKit
import JVChangeableValue
import JVTextField
import JVView
import JVInputValidator

open class TableViewRowTextField: TableViewRow, ChangeableValues, InputValidateable {
    
    public var oldValue: String {
        get {
            return _oldValue()
        } set {
            fatalError()
        }
    }
    
    public var textFieldSetup = TextSetup()
    public var currentValue: String
    public var inputValidator = InputValidator(validationState: .valid)
    
    // Sends back if the currentValue == oldValue
    public var hasChanged: ((Bool) -> ())?
    public var didReturn: (() -> ())?
    
    let validationBlockUserInput: ((String) -> (Bool))
    var isFirstResponder: Bool
    
    private let validationToChangeValidationState: ((String) -> (Bool))
    private let keyboardReturnType: UIReturnKeyType
    private let placeholderText: String
    private let _oldValue: (() -> (String))
    
    public init<T: RawRepresentable>(identifier: T,
                                     placeholderText: String,
                                     validationBlockUserInput: @escaping ((String) -> (Bool)),
                                     validationToChangeValidationState: ((String) -> (Bool))? = nil,
                                     keyboardReturnType: UIReturnKeyType = .done,
                                     oldValue: @escaping (() -> (String)) = { return "" },
                                     isFirstResponder: Bool = false) {
        self._oldValue = oldValue

        self.validationBlockUserInput = validationBlockUserInput
        self.validationToChangeValidationState = validationToChangeValidationState ?? validationBlockUserInput
        self.placeholderText = placeholderText
        self.keyboardReturnType = keyboardReturnType
        self.isFirstResponder = isFirstResponder
        currentValue = oldValue()
        
        super.init(identifier: identifier)
        
        assert(validationBlockUserInput(""), "No input shouldn't be blocked.")
    }
    
    open override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellTextField
        
        _cell.oldValue = oldValue
        _cell.textField.set(font: textFieldSetup.font, placeholderText: placeholderText)
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
}
