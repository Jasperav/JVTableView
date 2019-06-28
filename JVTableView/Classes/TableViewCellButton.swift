import JVView
import JVConstraintEdges
import JVCurrentDevice
import JVTableViewCellLayoutCreator

open class TableViewCellButton: TableViewCell {
    
    public let button = UIButton(type: .system)
    
    open override var middleView: UIView {
        return button
    }
    
    open override func setup() {
        super.setup()
        
        button.isUserInteractionEnabled = false
        
        if CurrentDevice.isRightToLeftLanguage {
            button.contentHorizontalAlignment = .right
        } else {
            button.contentHorizontalAlignment = .left
        }
    }
    
}
