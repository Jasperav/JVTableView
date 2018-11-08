import JVView

public class TableViewRowLabelImage: TableViewRowLabel {
    
    public override class func determineClassIdentifier() -> JVTableViewStdCell {
        return JVTableViewStdCell.labelImage
    }
    
    public let image: UIImage
    
    public init(identifier: String = "",
                text: String? = nil,
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                isSelectable: Bool = false,
                accessoryType: UITableViewCell.AccessoryType = .none,
                image: UIImage) {
        
        self.image = image
        
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, isSelectable: isSelectable, accessoryType: accessoryType)
    }
    public override func isVisible(_ cell: TableViewCellLabel) {
        let _cell = cell as! TableViewCellLabelImage
        
        _cell._imageView.image = image
    }
}
