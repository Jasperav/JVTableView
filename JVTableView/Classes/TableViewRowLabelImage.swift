import JVView
import JVNoParameterInitializable

open class TableViewRowLabelImage: TableViewRowLabel {
    
    /// Changing this property alone does not change the image of the cell property itself
    /// This has only effect when the cell reappears.
    public var image: UIImage?
    
    public init<T: RawRepresentable>(identifier: T,
                text: String = "",
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator,
                image: UIImage? = nil,
                showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil,
                tapped: (() -> ())? = nil) {
        self.image = image
        
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: accessoryType, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
        
        commonLoad()
    }
    
//    public init(rawIdentifier: String = TableViewRow.defaultRowIdentifier,
//                text: String = "",
//                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
//                accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator,
//                image: UIImage? = nil,
//                showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil,
//                tapped: (() -> ())? = nil) {
//        self.image = image
//        
//        super.init(rawIdentifier: rawIdentifier, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: accessoryType, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
//        
//        commonLoad()
//    }
    
    private func commonLoad() {
        changeClassType(cell: .labelImage)
    }
    
    open override func configure(cell: TableViewCell) {
        if shouldUpdateImage() {
            let _cell = cell as! TableViewCellLabelImage
            
            if let image = image {
                _cell.loadableImageView.show(image: image)
            } else {
                _cell.loadableImageView.showIndicator()
            }
        }
        
        super.configure(cell: cell)
    }
    
    open func shouldUpdateImage() -> Bool {
        return true
    }
}
