import JVView
import JVConstraintEdges
import JVCurrentDevice
import JVTableViewCellLayoutCreator

open class TableViewCellButton: TableViewCell {
    
    public let button = UIButton(type: .system)
    
    open override func setup() {
        TableViewCellLayoutCreator.create(middleView: button, toCell: self)
        
        button.isUserInteractionEnabled = false
        
        if CurrentDevice.isRightToLeftLanguage {
            button.contentHorizontalAlignment = .right
        } else {
            button.contentHorizontalAlignment = .left
        }
    }
    
}
