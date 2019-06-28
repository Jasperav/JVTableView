import UIKit
import JVView
import JVChangeableValue

public class TableViewRowLabelSwitch: TableViewRowLabel, ChangeableValues {
    public typealias HideRows = [(hide: Bool, identifier: String)]
    
    open override var classType: TableViewCell.Type {
        return TableViewCellLabelSwitch.self
    }
    
    public var oldValue: Bool {
        get {
            return _oldValue()
        } set {
            _oldValue = { return newValue }
        }
    }
    
    public var hideRows: ((_ currentValue: Bool) -> HideRows) = { _ in return [] }
    public var hasChanged: ((Bool) -> ())?
    public var currentValue: Bool
    
    private var _oldValue: (() -> (Bool))
    
    public init<T: RawRepresentable>(identifier: T, text: String, currentValue: @escaping (() -> (Bool))) {
        self._oldValue = currentValue
        self.currentValue = currentValue()
        
        super.init(identifier: identifier, text: text)
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
    
    public override func makeUnselectable(cell: TableViewCell) {
        // Do nothing, else the label gets grayed out
    }
    
    public override func commonLoad() {
        isSelectable = {
            return false
        }
        
        super.commonLoad()
    }
}
