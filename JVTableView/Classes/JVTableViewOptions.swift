import JVConstraintEdges
import JVView

public struct JVTableViewOptions {
    public let footer: JVTableViewFooterOptions
    
    public init(footerOptions: JVTableViewFooterOptions) {
        self.footer = footerOptions
    }
}

public struct JVTableViewFooterOptions {
    public let constraintEdges: ConstraintEdges
    public let contentTypeLabel: ContentTypeJVLabel
    
    public init(constraintEdges: ConstraintEdges = ConstraintEdges(leading: 15, trailing: 15, top: 3, bottom: 3), contentTypeLabel: ContentTypeJVLabel) {
        self.constraintEdges = constraintEdges
        self.contentTypeLabel = contentTypeLabel
    }
}

public struct JVTableViewHeaderStretchImage {
    public let height: CGFloat
    public let image: UIImage
    public let buttonImage: UIImage?
    public let tapped: (() -> ())?
    
    public init(height: CGFloat, image: UIImage, buttonImage: UIImage?, tapped: (() -> ())?) {
        self.height = height
        self.image = image
        self.buttonImage = buttonImage
        self.tapped = tapped
        
        assert(tapped != nil ? buttonImage != nil : true)
    }
}

open class JVTableViewHeaderStretchView: UIView {
    public var tapped: (() -> ())?
    
    public init(image: UIImage, buttonImage: UIImage?, tapped: (() -> ())?) {
        self.tapped = tapped
        
        super.init(frame: .zero)
        
        clipsToBounds = true
        
        addImageView(image: image)
        
        guard let buttonImage = buttonImage else { return }
        
        addButton(image: buttonImage)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func addImageView(image: UIImage) {
        let imageView = UIImageView(image: image)
        
        imageView.fill(toSuperview: self)
        imageView.contentMode = .scaleAspectFill
    }
    
    private func addButton(image: UIImage) {
        let button = UIButton(type: .custom)
        
        button.fill(toSuperview: self, edges: ConstraintEdges(leading: nil, trailing: 10, top: nil, bottom: 10))
        button.setHeight(35)
        button.setWidthAndHeightAreTheSame()
        
        button.setImage(image, for: .normal)
        button.imageView!.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(_tapped), for: .touchUpInside)
    }
    
    @objc private func _tapped() {
        tapped!()
    }
}
