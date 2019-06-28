import JVConstraintEdges
import JVLoadableImage

open class TableViewCellLabelImage: TableViewCellLabel {
    
    public let loadableImageView = LoadableMedia(style: .medium,
                                                 rounded: true,
                                                 isUserInteractionEnabled: false,
                                                 stretched: true)
    
    open override var leadingView: UIView? {
        return loadableImageView
    }
    
    open override func setup() {
        super.setup()
        
        loadableImageView.layoutSquare()
    }
}
