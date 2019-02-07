import JVView
import JVNoParameterInitializable

open class TableViewRowLabel: TableViewRow {
    
    public static var standardContentTypeJVLabel: ContentTypeJVLabelText!
    
    public var accessoryType: UITableViewCell.AccessoryType
    public var contentTypeJVLabel: ContentTypeJVLabelText
    public var _text: String? = nil
    
    public init(identifier: String = "",
                isVisible: ((_ cell: UITableViewCell) -> ())? = nil,
                text: String? = nil,
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator,
                showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) {
        self.contentTypeJVLabel = contentTypeJVLabel
        self._text = text
        self.accessoryType = accessoryType
        
        super.init(cell: .label, isVisible: isVisible, identifier: identifier, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
        
        self.isSelectable = accessoryType != .none
        
        let isVisible: ((_ cell: UITableViewCell) -> ()) = { [weak self] (cell) in
            let _cell = cell as! TableViewCellLabel
            
            self?.isVisible(_cell)
        }
        
        self.isVisible = isVisible
        
        assert(accessoryType != .none ? isSelectable : !isSelectable)
        assert(tapped == nil ? true : isSelectable)
        assert(showViewControllerOnTap == nil ? true : isSelectable)
    }
    
    open func isVisible(_ cell: TableViewCellLabel) {
        cell.update(contentTypeJVLabelText: contentTypeJVLabel, accessoryType: accessoryType, text: _text)
    }
}
