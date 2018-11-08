import UIKit
import JVConstraintEdges

open class TableViewCellTextField: UITableViewCell, ChangeableValues {
    open var edges = ConstraintEdges(all: 10)
    
    public var currentValue = ""
    public var oldValue: (() -> (String))?
    public var hasChanged: ((Bool) -> ())?
    public let textField = UITextField(frame: CGRect.zero)
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonLoad()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        commonLoad()
    }
    
    open func commonLoad() {
        assert(textField.superview == nil)
        
        textField.fill(toSuperview: contentView, edges: edges)
        
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        textField.delegate = self
    }
}

extension TableViewCellTextField: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // https://stackoverflow.com/questions/25621496/how-shouldchangecharactersinrange-works-in-swift
        // With the newValue property, we also want to include the added/removed character
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            currentValue = text.replacingCharacters(in: textRange,
                                                    with: string)
        } else {
            currentValue = ""
        }
        
        hasChanged?(determineHasBeenChanged())
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
