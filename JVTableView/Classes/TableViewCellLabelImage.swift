import JVConstraintEdges
import JVLoadableImage

open class TableViewCellLabelImage: TableViewCellLabel {
    
    public let loadableImageView = LoadableImage(style: .gray, rounded: true)
    
    open override func setup() {
        loadableImageView.fill(toSuperview: contentView, edges: TableViewRow.edges)
        
        super.setup()
        
        loadableImageView.equal(to: label, height: true, width: false)
        loadableImageView.setSameCenterY(view: label)
        loadableImageView.setContentHuggingAndCompressionResistance(1)
        loadableImageView.setWidthAndHeightAreTheSame()
    }
    
    open override func determineLeadingView() -> UIView? {
        return loadableImageView
    }
}
