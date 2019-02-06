import JVView
import JVNoParameterInitializable

public class TableViewRowLabelImage: TableViewRowLabel {
    
    public let image: UIImage
    
    public init(identifier: String = "",
                text: String? = nil,
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                isSelectable: Bool = false,
                accessoryType: UITableViewCell.AccessoryType = .none,
                showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil,
                image: UIImage) {
        
        self.image = image
        
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, isSelectable: isSelectable, accessoryType: accessoryType, showViewControllerOnTap: showViewControllerOnTap)
        
        classIdentifier = JVTableViewStdCell.labelImage.rawValue
    }
    public override func isVisible(_ cell: TableViewCellLabel) {
        let _cell = cell as! TableViewCellLabelImage
        
        _cell._imageView.image = image
        
        super.isVisible(cell)
    }
}
