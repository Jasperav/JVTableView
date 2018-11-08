import JVContentType

public final class ContentTypeJVButtonGrow: ContentType, Copyable {

    public static var allTypes = Set<ContentTypeJVButtonGrow>()
    
    public var contentTypeId: String?
    public let addSize: CGSize
    
    public init(contentTypeId: String?, addSize: CGSize) {
        self.contentTypeId = contentTypeId
        self.addSize = addSize
    }
    
    public init(old: ContentTypeJVButtonGrow, newContentTypeId: String?) {
        contentTypeId = newContentTypeId
        addSize = old.addSize
    }
}
