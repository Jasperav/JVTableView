import UIKit
import JVView
import JVConstraintEdges
import JVTableViewCellLayoutCreator

open class TableViewCellLabel: TableViewCell {
    
    public let label = UILabel(frame: .zero)
    
    open override var middleView: UIView {
        return label
    }
    
}
