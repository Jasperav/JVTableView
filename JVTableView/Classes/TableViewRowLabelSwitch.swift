import UIKit
import JVView
import JVChangeableValue

public class TableViewRowLabelSwitch: TableViewRowLabel, ChangeableValues {
    public var hasChanged: ((Bool) -> ())?
    
    // Since the switch's value should always be dynamic, the user must provide the actual value of the switch at runtime.
    public var oldValue = false
    public var currentValue = false
    
    public init<T: RawRepresentable>(identifier: T,
                text: String = "",
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel) where T.RawValue == String {
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: .none, showViewControllerOnTap: nil)
        
        changeClassType(cell: JVTableViewStdCell.labelSwitch)
    }
    
    public override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellLabelSwitch
        
        _cell._switch.isOn = currentValue
        _cell.oldValue = oldValue
        
        _cell.hasChanged = { [unowned self] (hasChanged) in
            self.currentValue = _cell._switch.isOn
            self.hasChanged?(self.determineHasBeenChanged())
        }
        
        super.configure(cell: cell)
    }
    
    public override func determineUpdateType() -> TableViewRowUpdateType {
        return .bool(currentValue)
    }
}
