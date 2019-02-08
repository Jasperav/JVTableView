import UIKit
import JVConstraintEdges

open class TableViewCellTextField: TableViewCell, ChangeableValues, UITextFieldDelegate {
    open var edges = ConstraintEdges(all: 10)
    
    public var currentValue = ""
    public var oldValue: (() -> (String))?
    public var hasChanged: ((Bool) -> ())?
    public let textField = UITextField(frame: CGRect.zero)
    public var validate: ((String) -> (Bool))!
    public var didReturn: (() -> ())?
    
    open override func configure() {
        assert(textField.superview == nil)
        
        textField.fill(toSuperview: contentView, edges: edges)
        
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        textField.delegate = self
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newValue: String
        
        // https://stackoverflow.com/questions/25621496/how-shouldchangecharactersinrange-works-in-swift
        // With the newValue property, we also want to include the added/removed character
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            newValue = text.replacingCharacters(in: textRange, with: string)
        } else {
            newValue = ""
        }
        
        let pressedBackSpaceAndHasPlaceHolderText = newValue == "" && textField.placeholder != nil
        
        guard validate(newValue) || pressedBackSpaceAndHasPlaceHolderText else { return false }
        
        currentValue = newValue
        
        hasChanged?(determineHasBeenChanged())
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        didReturn?()
        
        return true
    }
}
