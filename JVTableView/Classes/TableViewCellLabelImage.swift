import JVConstraintEdges

public class TableViewCellLabelImage: TableViewCellLabel {
    public let _imageView = UIImageView(frame: CGRect.zero)
    open var edgesImageView = ConstraintEdges(leading: 5)
    
    public override func setup() {
        _imageView.fill(toSuperview: contentView, edges: edgesImageView)
        
        _imageView.equal(to: label, height: true, width: false)
        _imageView.setSameCenterY(view: label)
        _imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        _imageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        _imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        _imageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 249), for: .vertical)
        _imageView.setWidthAndHeightAreTheSame()
        
        super.setup()
    }
    
    public override func determineLeadingView() -> UIView? {
        return _imageView
    }
}
