/// Copys the content of the old contentTypeId into the new contentTypeId
public protocol Copyable: class {
    
    /// Make this class func in an inherence tree
    /// When a class implements this method but also implements the content type protocol
    /// the contentTypeId shoud NOT be copied
    init(old: Self, newContentTypeId: String?)
}

public extension Copyable {
    func copy(newContentTypeId: String? = nil) -> Self {
        return Self.init(old: self, newContentTypeId: newContentTypeId)
    }
}

public extension Copyable where Self: ContentType {
    /// Gets the content type but copied.
    static func copyContentType(contentTypeId: String) -> Self {
        let instance = Self.allTypes.first(where: { $0.contentTypeId == contentTypeId })!
        return Self.copyContentType(contentType: instance)
    }
    
    static func copyContentType(contentType: Self, newContentTypeId: String? = nil) -> Self {
        return Self(old: contentType, newContentTypeId: newContentTypeId)
    }
}
