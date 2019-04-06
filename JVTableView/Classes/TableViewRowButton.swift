import JVView
import JVNoParameterInitializable
import JVURLOpener

open class TableViewRowButton: TableViewRowText {
    
    public init<T: RawRepresentable>(identifier: T,
                                     text: String,
                                     contentTypeJVLabel: ContentTypeJVLabel = TableViewRowText.standardContentTypeJVLabel,
                                     url: String) {
        super.init(cell: .button, identifier: identifier, accessoryType: .disclosureIndicator, contentTypeJVLabel: contentTypeJVLabel, text: text, showViewControllerOnTap: nil, tapped: {
            URLOpener.open(url: url)
        })
        
        commonLoad()
    }
    
    public init(rawIdentifier: String = TableViewRow.defaultRowIdentifier,
                text: String,
                contentTypeJVLabel: ContentTypeJVLabel = TableViewRowText.standardContentTypeJVLabel,
                url: String) {
        super.init(cell: .button, rawIdentifier: rawIdentifier, accessoryType: .disclosureIndicator, contentTypeJVLabel: contentTypeJVLabel, text: text, showViewControllerOnTap: nil) {
            URLOpener.open(url: url)
        }
        
        commonLoad()
    }
    
    private func commonLoad() {
        self.isSelectable = true
    }
    
    open override func update(cell: TableViewCell) {
        let _cell = cell as! TableViewCellButton
        
        _cell.button.titleLabel!.font = contentTypeJVLabel.contentTypeTextFont.font
        _cell.button.setTitle(_text, for: .normal)
    }
}
