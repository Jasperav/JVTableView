import JVView
import JVNoParameterInitializable

open class TableViewRowLabelImage: TableViewRowLabel {
    
    /// Changing this property alone does not change the image of the cell property itself
    /// This has only effect when the cell reappears.
    public var image: UIImage?
    
    public init(identifier: String = "",
                isVisible: ((_ cell: UITableViewCell) -> ())? = nil,
                text: String? = nil,
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator,
                image: UIImage?,
                showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil,
                tapped: (() -> ())? = nil) {
        
        self.image = image
        
        super.init(identifier: identifier, isVisible: isVisible, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: accessoryType, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
        
        changeClassType(cell: .labelImage)
    }
    
    open override func isVisible(_ cell: TableViewCellLabel) {
        let _cell = cell as! TableViewCellLabelImage
        
        if let image = image {
            _cell.loadableImageView.show(image: image)
        } else {
            _cell.loadableImageView.showIndicator()
        }
        
        super.isVisible(cell)
    }
}
