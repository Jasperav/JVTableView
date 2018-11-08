import JVContentType

public final class ContentTypeJVGradientLayer: ContentTypeGroup, Copyable {
    
    public static var allTypes = Set<ContentTypeJVGradientLayer>()
    
    public var contentTypeId: String?
    public var contentTypeGroupId: [String]?
    public var color: CGColor
    public var gradientLocation: NSNumber
    public var startPoint: CGPoint?
    public var endPoint: CGPoint?
    
    public convenience init(color: CGColor, location: NSNumber) {
        self.init(contentTypeId: nil, contentTypeGroupId: nil, color: color, gradientLocation: location, startPoint: nil, endPoint: nil)
    }
    
    public init(contentTypeId: String?, contentTypeGroupId: [String]?, color: CGColor, gradientLocation: NSNumber, startPoint: CGPoint?, endPoint: CGPoint?) {
        self.contentTypeId = contentTypeId
        self.contentTypeGroupId = contentTypeGroupId
        self.color = color
        self.gradientLocation = gradientLocation
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    public required init(old: ContentTypeJVGradientLayer, newContentTypeId: String?) {
        contentTypeId = newContentTypeId
        contentTypeGroupId = old.contentTypeGroupId
        color = old.color
        gradientLocation = old.gradientLocation
        startPoint = old.startPoint
        endPoint = old.endPoint
    }
    
}
