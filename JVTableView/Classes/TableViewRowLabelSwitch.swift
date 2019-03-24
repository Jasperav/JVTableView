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
                                     contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel) {
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: .none, showViewControllerOnTap: nil)
        
        commonLoad()
    }
    
    public init(rawIdentifier: String = TableViewRow.defaultRowIdentifier,
                text: String = "",
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel) {
        super.init(rawIdentifier: rawIdentifier, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: .none, showViewControllerOnTap: nil)
        
        commonLoad()
    }
    
    private func commonLoad() {
        changeClassType(cell: JVTableViewStdCell.labelSwitch)
    }
    
    public override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellLabelSwitch
        
        _cell._switch.isOn = currentValue
        _cell.oldValue = oldValue
        
        _cell.hasChanged = { [unowned self] (hasChanged) in
            self.currentValue = _cell._switch.isOn
            self.hasChanged?(self.isChanged)
        }
        
        super.configure(cell: cell)
    }
    
    public override func createUpdateContainer() -> TableViewRowUpdateContainer {
        return .bool(currentValue)
    }
}
