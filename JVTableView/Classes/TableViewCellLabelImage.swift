import JVConstraintEdges
import JVLoadableImage

open class TableViewCellLabelImage: TableViewCellLabel {
    
    public let loadableImageView = LoadableImage(style: .gray, rounded: true, isUserInteractionEnabled: false)
    
    open override var leadingView: UIView? {
        return loadableImageView
    }
    
    open override func setup() {
        super.setup()
        
        loadableImageView.isSquare = true
    }
}
