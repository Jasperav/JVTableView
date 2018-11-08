public protocol ContentTypeGroupInitializable: ContentTypeGroup {
    init()
    init(contentTypeId: String?)
}

public extension ContentTypeGroupInitializable {
    public init() {
        self.init()
    }
    
    public init(contentTypeId: String?) {
        self.init()
        self.contentTypeId = contentTypeId
    }
}
