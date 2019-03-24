import UIKit
import JVChangeableValue

public class TableViewCellLabelSwitch: TableViewCellLabel, ChangeableValues {
    
    public override var trailingView: UIView? {
        return accessoryView
    }
    
    public var currentValue = false
    public var oldValue = false
    public var hasChanged: ((Bool) -> ())?
    public let _switch = UISwitch(frame: CGRect.zero)
    
    open override func setup() {
        accessoryView = _switch
        
        _switch.addTarget(self, action: #selector(valueChange), for: .valueChanged)
        
        super.setup()
    }
    
    @objc func valueChange() {
        currentValue = _switch.isOn
        
        hasChanged?(isChanged)
    }
}
