import JVContentType

public final class ContentTypeConstraintEdges: ContentType, Copyable {

    public static var allTypes = Set<ContentTypeConstraintEdges>()
    
    public var contentTypeId: String?
    public let constraintEdges: ConstraintEdges
    
    public init(contentTypeId: String, constraintEdges: ConstraintEdges) {
        self.contentTypeId = contentTypeId
        self.constraintEdges = constraintEdges
    }
    
    public required init(old: ContentTypeConstraintEdges, newContentTypeId: String?) {
        contentTypeId = newContentTypeId
        constraintEdges = old.constraintEdges
    }
    
}
