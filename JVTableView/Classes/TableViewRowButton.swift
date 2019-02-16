import JVView
import JVNoParameterInitializable

open class TableViewRowButton: TableViewRowText {
    public init(identifier: String = TableViewRow.defaultRowIdentifier,
                text: String = "",
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowText.standardContentTypeJVLabel,
                accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator,
                showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) {

        super.init(cell: .button, identifier: identifier, accessoryType: accessoryType, contentTypeJVLabel: contentTypeJVLabel, text: text, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
        
        self.isSelectable = true
        
        assert(accessoryType != .none)
    }
    
    open override func update(cell: TableViewCell) {
        let _cell = cell as! TableViewCellButton
        
        _cell.update(contentTypeJVLabelText: contentTypeJVLabel, text: _text)
    }
}