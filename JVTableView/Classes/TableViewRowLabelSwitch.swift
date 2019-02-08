import UIKit
import JVView

public class TableViewRowLabelSwitch: TableViewRowLabel, ChangeableValues {
    public var hasChanged: ((Bool) -> ())?
    public var oldValue: (() -> (Bool))?
    public var currentValue: Bool
    
    public init(identifier: String = "",
                configureInstant: ((_ cell: UITableViewCell) -> ())? = nil,
                text: String? = nil,
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                oldValue: (() -> (Bool))? = nil
        ) {
        self.oldValue = oldValue
        currentValue = oldValue?() ?? false
        
        super.init(identifier: identifier, configureInstant: configureInstant, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: .none, showViewControllerOnTap: nil)
        
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
}
