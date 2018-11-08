import JVView

open class JVLabelCellOptionsImage: JVLabelCellOptions {
    public let image: UIImage
    
    public init(contentTypeJVLabelText: ContentTypeJVLabelText, accessoryType: UITableViewCell.AccessoryType, image: UIImage) {
        self.image = image
        
        super.init(contentTypeJVLabelText: contentTypeJVLabelText, accessoryType: accessoryType)
    }
}
