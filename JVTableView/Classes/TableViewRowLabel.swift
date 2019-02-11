import JVView
import JVNoParameterInitializable

open class TableViewRowLabel: TableViewRowText {
    
    public init(identifier: String = TableViewRow.defaultRowIdentifier,
                text: String? = nil,
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowText.standardContentTypeJVLabel,
                accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator,
                showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) {

        
        super.init(cell: .label, identifier: identifier, accessoryType: accessoryType, contentTypeJVLabel: contentTypeJVLabel, text: text, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
        
        self.isSelectable = accessoryType != .none
        
        assert(accessoryType != .none ? isSelectable : !isSelectable)
        assert(tapped == nil ? true : isSelectable)
        assert(showViewControllerOnTap == nil ? true : isSelectable)
    }
    
    open override func update(cell: TableViewCell) {
        (cell as! TableViewCellLabel).updateLabel(contentTypeJVLabelText: contentTypeJVLabel, text: _text)
    }
}
