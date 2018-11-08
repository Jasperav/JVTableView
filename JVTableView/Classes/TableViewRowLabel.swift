import JVTappable
import JVView

open class TableViewRowLabel: TableViewRow, Tappable {
    
    public var tapped: (() -> ())?
    public let cellOptions: JVLabelCellOptions
    public var _text: String? = nil
    
    public init(identifier: String,
                cellOptions: JVLabelCellOptions,
                isSelectable: Bool,
                text: String? = nil) {
        self.cellOptions = cellOptions
        self._text = text
        
        super.init(cell: .label, isVisible: nil, identifier: identifier)
        
        self.isSelectable = isSelectable
        
        let isVisible: ((_ cell: UITableViewCell) -> ()) = { [weak self] (cell) in
            let _cell = cell as! TableViewCellLabel
            
            self?.isVisible(_cell)
        }
        
        self.isVisible = isVisible
    }
    
    fileprivate func resetCell(_ cell: TableViewCellLabel) {
        cell.update(options: cellOptions, text: _text)
    }
    
    open func isVisible(_ cell: TableViewCellLabel) {
        resetCell(cell)
    }
}
