import JVView
import JVNoParameterInitializable

open class TableViewRowLabelImage: TableViewRowLabel {
    
    open override var classType: TableViewCell.Type {
        return TableViewCellLabelImage.self
    }
    
    public enum Image {
        case image(UIImage), imageIdentifier(Int64)
    }
    
    private let image: (() -> (Image))
    
    public init<T: RawRepresentable>(identifier: T, text: String, image: @escaping (() -> (Image))) {
        self.image = image
        
        super.init(identifier: identifier, text: text)
    }
    
    public init(text: @escaping (() -> (String)), image: @escaping (() -> (Image))) {
        self.image = image
        
        super.init(text: text)
    }
    
    public init(text: String, image: @escaping (() -> (Image))) {
        self.image = image
        
        super.init(text: text)
    }
    
    open override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellLabelImage
        
        switch image() {
        case .image(let image):
            _cell.loadableImageView.forceChange(state: .highResolutionImage(image))
        case .imageIdentifier(let imageIdentifier):
            JVTableViewHeaderImageCache.handle(imageIdentifier, _cell.loadableImageView)
        }
        
        super.configure(cell: cell)
    }
    
}
