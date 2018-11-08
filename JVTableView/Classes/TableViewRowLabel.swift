import JVTappable
import JVView

open class TableViewRowLabel: TableViewRow, Tappable {
    
    public let accessoryType: UITableViewCell.AccessoryType
    public var tapped: (() -> ())?
    public let contentTypeJVLabel: ContentTypeJVLabelText
    public var _text: String? = nil
    
    public init(identifier: String,
                contentTypeJVLabel: ContentTypeJVLabelText,
                isSelectable: Bool,
                accessoryType: UITableViewCell.AccessoryType = .none,
                text: String? = nil) {
        self.contentTypeJVLabel = contentTypeJVLabel
        self._text = text
        self.accessoryType = accessoryType
        
        super.init(cell: .label, isVisible: nil, identifier: identifier)
        
        self.isSelectable = isSelectable
        
        let isVisible: ((_ cell: UITableViewCell) -> ()) = { [weak self] (cell) in
            let _cell = cell as! TableViewCellLabel
            
            self?.isVisible(_cell)
        }
        
        self.isVisible = isVisible
    }
    
    open func isVisible(_ cell: TableViewCellLabel) {
        cell.update(contentTypeJVLabelText: contentTypeJVLabel, accessoryType: accessoryType, text: _text)
    }
}
