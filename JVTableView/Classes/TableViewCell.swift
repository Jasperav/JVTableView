import JVTableViewCellLayoutCreator
import JVConstraintEdges

open class TableViewCell: TableViewCellInnerContentView {
    static let edges = ConstraintEdges(height: 15, width: 15)
    
    var identifier: String?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setup() {
        fatalError()
    }
}
