import UIKit
import JVView
import JVChangeableValue

public class TableViewRowLabelSwitch: TableViewRowLabel, ChangeableValues {
    public var hasChanged: ((Bool) -> ())?
    public var oldValue = false
    public var currentValue: Bool
    
    public init(identifier: String = TableViewRow.defaultRowIdentifier,
                text: String = "",
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                oldValue: Bool = false
        ) {
        self.oldValue = oldValue
        
        currentValue = oldValue
        
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
