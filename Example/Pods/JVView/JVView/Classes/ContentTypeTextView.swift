import JVContentType

public final class ContentTypeTextView: ContentType, Copyable {
    
    public static var allTypes = Set<ContentTypeTextView>()
    
    public var contentTypeId: String?
    public var contentTypeTextFont: ContentTypeTextFont
    
    public init(contentTypeId: String, contentTypeTextFont: ContentTypeTextFont) {
        self.contentTypeId = contentTypeId
        self.contentTypeTextFont = contentTypeTextFont
    }
    
    public init(old: ContentTypeTextView, newContentTypeId: String?) {
        contentTypeTextFont = old.contentTypeTextFont.copy()
    }
}
