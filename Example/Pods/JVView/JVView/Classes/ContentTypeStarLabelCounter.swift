import JVContentType

public final class ContentTypeJVLabelCountingLabel: ContentType, Copyable {
    
    public static var allTypes = Set<ContentTypeJVLabelCountingLabel>()
    
    public var contentTypeId: String?
    public var formatter: Formatter
    public var animationType: CountingAnimationType
    public var animationDuration: TimeInterval
    public var frameRate: Int
    
    public init(contentTypeId: String?, formatter: Formatter, animationType: CountingAnimationType, animationDuration: TimeInterval, frameRate: Int) {
        self.contentTypeId = contentTypeId
        self.formatter = formatter
        self.animationType = animationType
        self.animationDuration = animationDuration
        self.frameRate = frameRate
    }
    
    public init(old: ContentTypeJVLabelCountingLabel, newContentTypeId: String?) {
        contentTypeId = newContentTypeId
        
        formatter = old.formatter
        animationType = old.animationType
        animationDuration = old.animationDuration
        frameRate = old.frameRate
    }
}
