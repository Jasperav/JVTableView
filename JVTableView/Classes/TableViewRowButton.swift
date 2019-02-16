import JVView
import JVNoParameterInitializable
import JVURLOpener

open class TableViewRowButton: TableViewRowText {
    public init(identifier: String = TableViewRow.defaultRowIdentifier,
                text: String = "",
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowText.standardContentTypeJVLabel,
                accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator,
                showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil,
                url: String) {

        super.init(cell: .button, identifier: identifier, accessoryType: accessoryType, contentTypeJVLabel: contentTypeJVLabel, text: text, showViewControllerOnTap: showViewControllerOnTap, tapped: {
            URLOpener.open(url: url)
        })
        
        self.isSelectable = true
        
        assert(accessoryType != .none)
    }
    
    open override func update(cell: TableViewCell) {
        let _cell = cell as! TableViewCellButton
        
        _cell.update(contentTypeJVLabelText: contentTypeJVLabel, text: _text)
    }
}
