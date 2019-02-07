import JVView
import JVNoParameterInitializable

public class TableViewRowLabelImage: TableViewRowLabel {
    
    public let image: UIImage
    
    public init(identifier: String = "",
                isVisible: ((_ cell: UITableViewCell) -> ())? = nil,
                text: String? = nil,
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator,
                image: UIImage,
                showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil,
                tapped: (() -> ())? = nil) {
        
        self.image = image
        
        super.init(identifier: identifier, isVisible: isVisible, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: accessoryType, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
        
        changeClassType(cell: .labelImage)
    }
    public override func isVisible(_ cell: TableViewCellLabel) {
        let _cell = cell as! TableViewCellLabelImage
        
        _cell._imageView.image = image
        
        super.isVisible(cell)
    }
}
