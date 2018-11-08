public protocol ContentTypeInitializable: ContentType {
    init()
    init(contentTypeId: String?)
}

public extension ContentTypeInitializable {
    public init(contentTypeId: String?) {
        self.init()
        self.contentTypeId = contentTypeId
    }
}
