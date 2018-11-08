import JVView

public class TableViewRowLabelImage: TableViewRowLabel {
    
    public let image: UIImage
    
    public init(identifier: String, contentTypeJVLabel: ContentTypeJVLabelText, isSelectable: Bool, accessoryType: UITableViewCell.AccessoryType, text: String?, image: UIImage) {
        
        self.image = image
        
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, isSelectable: isSelectable, accessoryType: accessoryType)
    }
    public override func isVisible(_ cell: TableViewCellLabel) {
        let _cell = cell as! TableViewCellLabelImage
        
        _cell._imageView.image = image
    }
}
