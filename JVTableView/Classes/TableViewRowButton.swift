import JVView
import JVNoParameterInitializable
import JVURLOpener

open class TableViewRowButton: TableViewRowText {
    
    public init<T: RawRepresentable>(identifier: T? = nil,
                            text: String,
                            contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowText.standardContentTypeJVLabel,
                            url: String) where T.RawValue == String {
        super.init(cell: .button, identifier: identifier, accessoryType: .disclosureIndicator, contentTypeJVLabel: contentTypeJVLabel, text: text, showViewControllerOnTap: nil, tapped: {
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
