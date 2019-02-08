import UIKit

public class TableViewCellLabelSwitch: TableViewCellLabel, ChangeableValues {
    public var currentValue = false
    public var oldValue: (() -> (Bool))?
    public var hasChanged: ((Bool) -> ())?
    public let _switch = UISwitch(frame: CGRect.zero)
    
    open override func configure() {
        accessoryView = _switch
        
        _switch.addTarget(self, action: #selector(valueChange), for: .valueChanged)
        
        super.configure()
    }
    
    @objc func valueChange() {
        currentValue = _switch.isOn
        
        hasChanged?(determineHasBeenChanged())
    }
    
    public override func determineTrailingView() -> UIView? {
        return accessoryView
    }
}
