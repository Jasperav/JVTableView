import JVView

open class JVLabelCellOptionsImage: JVLabelCellOptions {
    public let image: UIImage
    
    public init(contentTypeJVLabelText: ContentTypeJVLabelText, image: UIImage) {
        self.image = image
        
        super.init(contentTypeJVLabelText: contentTypeJVLabelText)
    }
}
