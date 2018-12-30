import JVTappable
import JVView

open class TableViewRowLabel: TableViewRow, Tappable {
    
    public static var standardContentTypeJVLabel: ContentTypeJVLabelText!
    
    public var accessoryType: UITableViewCell.AccessoryType
    public var tapped: (() -> ())?
    public var contentTypeJVLabel: ContentTypeJVLabelText
    public var _text: String? = nil
    
    public init(identifier: String = "",
                text: String? = nil,
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                isSelectable: Bool = false,
                accessoryType: UITableViewCell.AccessoryType = .none) {
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
        
        assert(accessoryType != .none ? isSelectable : !isSelectable)
    }
    
    open func isVisible(_ cell: TableViewCellLabel) {
        cell.update(contentTypeJVLabelText: contentTypeJVLabel, accessoryType: accessoryType, text: _text)
    }
}
