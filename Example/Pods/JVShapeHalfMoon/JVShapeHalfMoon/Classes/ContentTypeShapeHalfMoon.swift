import JVContentType

public final class ContentTypeShapeHalfMoon: ContentType, Copyable {

    public static var allTypes = Set<ContentTypeShapeHalfMoon>()
    
    public var contentTypeId: String?
    public var gradient: CGColor
    public var gradientOnButtonClick: CGColor
    
    public init(contentTypeId: String?, gradient: CGColor, gradientOnButtonClick: CGColor) {
        self.contentTypeId = contentTypeId
        self.gradient = gradient
        self.gradientOnButtonClick = gradientOnButtonClick
    }
    
    public required init(old: ContentTypeShapeHalfMoon, newContentTypeId: String?) {
        contentTypeId = newContentTypeId
        gradient = old.gradient
        gradientOnButtonClick = old.gradientOnButtonClick
    }
}
