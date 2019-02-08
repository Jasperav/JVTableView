import JVConstraintEdges

public class TableViewCellLabelImage: TableViewCellLabel {
    public let _imageView = UIImageView(frame: CGRect.zero)
    open var edgesImageView = ConstraintEdges(leading: 10)
    
    public override func configure() {
        _imageView.fill(toSuperview: contentView, edges: edgesImageView)
        
        super.configure()
        
        _imageView.equal(to: label, height: true, width: false)
        _imageView.setSameCenterY(view: label)
        _imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .horizontal)
        _imageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1), for: .horizontal)
        _imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        _imageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1), for: .vertical)
        _imageView.setWidthAndHeightAreTheSame()
        _imageView.contentMode = .scaleAspectFit
    }
    
    public override func determineLeadingView() -> UIView? {
        return _imageView
    }
}
