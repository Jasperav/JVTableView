import UIKit
import JVView

public class TableViewRowLabelSwitch: TableViewRowLabel, ChangeableValues {
    public var hasChanged: ((Bool) -> ())?
    public let oldValue: (() -> (Bool))?
    public var currentValue: Bool
    public var changed: (() -> ())?
    
    public init(identifier: String,
                         contentTypeJVLabel: ContentTypeJVLabelText,
                         text: String?,
                         oldValue: (() -> (Bool))? = nil) {
        self.oldValue = oldValue
        currentValue = oldValue?() ?? false
        
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, isSelectable: false, accessoryType: .none)
    }
    
    public override func isVisible(_ cell: TableViewCellLabel) {
        let _cell = cell as! TableViewCellLabelSwitch
        
        _cell._switch.isOn = currentValue
        _cell.hasChanged = { [weak self] (hasChanged) in
            guard let strongSelf = self else { return }
            
            strongSelf.currentValue = hasChanged
            strongSelf.changed?()
        }
    }
}
