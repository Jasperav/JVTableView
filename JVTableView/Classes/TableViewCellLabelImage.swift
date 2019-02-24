import JVConstraintEdges
import JVLoadableImage

open class TableViewCellLabelImage: TableViewCellLabel {
    
    public let loadableImageView = LoadableImage(style: .gray, rounded: true)
    
    open override func setup() {
        super.setup()
        
        loadableImageView.setWidthAndHeightAreTheSame()
    }
    
    open override func determineLeadingView() -> UIView? {
        return loadableImageView
    }
}
