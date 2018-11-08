import JVContentType

open class ContentTypeJVLabelText: ContentTypeJVLabel {
    
    /// Is implicit unwrapped because sometimes we copy everything from ContentTypeJVLabel
    /// It is up to the user to add this property directly after the copying
    public var contentTypeTextFont: ContentTypeTextFont!
    
    public init(contentTypeId: String?,
                contentTypeTextFont: ContentTypeTextFont,
                textAligment: NSTextAlignment = .natural,
                initialText: String? = nil,
                numberOfLines: Int = 1) {
        self.contentTypeTextFont = contentTypeTextFont
        
        super.init(contentTypeId: contentTypeId,
                   textAligment: textAligment,
                   initialText: initialText,
                   numberOfLines: numberOfLines)
    }
    
    public required init(old: ContentTypeJVLabel, newContentTypeId: String?) {
        super.init(old: old, newContentTypeId: newContentTypeId)
        
        contentTypeTextFont = (old as? ContentTypeJVLabelText)?.contentTypeTextFont.copy()
    }
    
}
