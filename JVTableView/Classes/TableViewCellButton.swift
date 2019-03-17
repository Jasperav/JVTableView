import JVView
import JVConstraintEdges
import JVCurrentDevice
import JVTableViewCellLayoutCreator

open class TableViewCellButton: TableViewCell {
    
    public let button = UIButton(type: .system)
    
    open override func setup() {
        TableViewCellLayoutCreator.create(toCell: self, middleView: button)
        
        button.isUserInteractionEnabled = false
        
        if CurrentDevice.isRightToLeftLanguage {
            button.contentHorizontalAlignment = .right
        } else {
            button.contentHorizontalAlignment = .left
        }
    }
    
}
