import JVView
import JVNoParameterInitializable

open class TableViewRowLabel: TableViewRowText {
    
    public init<T: RawRepresentable>(identifier: T? = nil,
                text: String = "",
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowText.standardContentTypeJVLabel,
                accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator,
                showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) where T.RawValue == String {

        
        super.init(cell: .label, identifier: identifier, accessoryType: accessoryType, contentTypeJVLabel: contentTypeJVLabel, text: text, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
        
        self.isSelectable = accessoryType != .none
        
        assert(accessoryType != .none ? isSelectable : !isSelectable)
        assert(tapped == nil ? true : isSelectable)
        assert(showViewControllerOnTap == nil ? true : isSelectable)
    }
    
    open override func update(cell: TableViewCell) {
        (cell as! TableViewCellLabel).updateLabel(contentTypeJVLabelText: contentTypeJVLabel, text: _text)
    }
    
    @discardableResult
    public func makeDestructive() -> TableViewRowLabel {
        contentTypeJVLabel = contentTypeJVLabel.changeColor(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        
        return self
    }
}
