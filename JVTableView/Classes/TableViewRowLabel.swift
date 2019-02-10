import JVView
import JVNoParameterInitializable

open class TableViewRowLabel: TableViewRow {
    
    public static var standardContentTypeJVLabel: ContentTypeJVLabelText!
    
    public var accessoryType: UITableViewCell.AccessoryType
    public var contentTypeJVLabel: ContentTypeJVLabelText
    public var _text: String? = nil
    
    public init(identifier: String = "",
               
                text: String? = nil,
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator,
                showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) {
        self.contentTypeJVLabel = contentTypeJVLabel.copy(contentTypeId: nil)
        self._text = text
        self.accessoryType = accessoryType
        
        super.init(cell: .label, identifier: identifier, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
        
        self.isSelectable = accessoryType != .none
        
        assert(accessoryType != .none ? isSelectable : !isSelectable)
        assert(tapped == nil ? true : isSelectable)
        assert(showViewControllerOnTap == nil ? true : isSelectable)
    }
    
    open override func configure(cell: TableViewCell) {
        (cell as! TableViewCellLabel).update(contentTypeJVLabelText: contentTypeJVLabel, accessoryType: accessoryType, text: _text)
    }
}
