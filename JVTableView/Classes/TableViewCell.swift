import JVTableViewCellLayoutCreator
import JVConstraintEdges
import JVDebugProcessorMacros

open class TableViewCell: TableViewCellInnerContentView {
    
    open override class var edges: ConstraintEdges {
        return ConstraintEdges(height: 15, width: 15)
    }
    
    open var leadingView: UIView? {
        return nil
    }
    
    open var trailingView: UIView? {
        return nil
    }
    
    open var middleView: UIView {
        fatalError()
    }
    
    var identifier: String?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    /// One-time setup, called once.
    open func setup() {
        let trailingView: UIView?
        
        if let _trailingView = self.trailingView, _trailingView != accessoryView {
            trailingView = _trailingView
        } else {
            trailingView = nil
        }
        
        TableViewCellLayoutCreator.layout(cell: self,
                                          middleView: middleView,
                                          leadingView: leadingView,
                                          trailingView: trailingView)
    }

}
