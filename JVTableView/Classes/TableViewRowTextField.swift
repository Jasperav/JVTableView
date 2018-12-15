import UIKit

public class TableViewRowTextField: TableViewRow, ChangeableValues {
    
    public var oldValue: (() -> (String))?
    public var currentValue: String
    
    // Sends back if the currentValue == oldValue
    public var hasChanged: ((Bool) -> ())?
    public var validate: ((String) -> (Bool))
    
    public init(identifier: String, placeholderText: String, validate: @escaping ((String) -> (Bool)), oldValue: (() -> (String))? = nil) {
        self.oldValue = oldValue
        self.validate = validate
        currentValue = oldValue?() ?? ""
        
        super.init(cell: JVTableViewStdCell.textField,
                   isVisible: nil,
                   identifier: identifier)
        
        let isVisible: ((_ cell: UITableViewCell) -> ()) = { [weak self] (cell) in
            guard let strongSelf = self else { return }
            let _cell = cell as! TableViewCellTextField
            
            _cell.oldValue = strongSelf.oldValue
            _cell.textField.placeholder = placeholderText
            _cell.textField.text = strongSelf.currentValue
            _cell.textField.accessibilityIdentifier = identifier
            _cell.validate = validate
            
            _cell.hasChanged = { (hasChanged) in
                strongSelf.currentValue = _cell.currentValue
                strongSelf.hasChanged?(hasChanged)
            }
        }
        
        self.isVisible = isVisible
    }
    
    public func setCurrentValue() {
        
    }
}
