import UIKit
import JVView

public class TableViewRowLabelSwitch: TableViewRowLabel, ChangeableValues {
    public var hasChanged: ((Bool) -> ())?
    public var oldValue: (() -> (Bool))?
    public var currentValue: Bool
    
    public init(identifier: String = "",
                text: String? = nil,
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                oldValue: (() -> (Bool))? = nil
        ) {
        self.oldValue = oldValue
        currentValue = oldValue?() ?? false
        
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, isSelectable: false, accessoryType: .none)
        
        classIdentifier = JVTableViewStdCell.labelSwitch.rawValue
    }
    
    public override func isVisible(_ cell: TableViewCellLabel) {
        let _cell = cell as! TableViewCellLabelSwitch
        
        _cell._switch.isOn = currentValue
        _cell.oldValue = oldValue
        _cell.hasChanged = { [weak self] (hasChanged) in
            guard let strongSelf = self else { return }
            
            strongSelf.currentValue = hasChanged
            strongSelf.hasChanged?(strongSelf.determineHasBeenChanged())
        }
        
        super.isVisible(cell)
    }
}
