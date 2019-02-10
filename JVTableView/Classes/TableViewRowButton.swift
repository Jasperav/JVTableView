import JVView
import JVNoParameterInitializable

class TableViewRowButton: TableViewRowText {
    public init(identifier: String = "",
                text: String? = nil,
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowText.standardContentTypeJVLabel,
                accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator,
                showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) {

        super.init(cell: .button, identifier: identifier, accessoryType: accessoryType, contentTypeJVLabel: contentTypeJVLabel, text: text, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
        
        self.isSelectable = true
        
        assert(accessoryType != .none)
    }
    
    override func update(cell: TableViewCell) {
        let _cell = cell as! TableViewCellButton
        
        _cell.update(contentTypeJVLabelText: contentTypeJVLabel, text: _text)
    }
}
