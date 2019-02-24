import JVTableViewCellLayoutCreator

open class TableViewCell: TableViewCellInnerContentView {
    
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
