import JVContentType

open class ContentTypeJVLabelTextCountingLabel: ContentTypeJVLabelText {
    public var contentTypeJVLabelCountingLabel: ContentTypeJVLabelCountingLabel!
    
    public init(contentTypeId: String?,
                textAligment: NSTextAlignment = .natural,
                contentTypeTextFont: ContentTypeTextFont,
                contentTypeJVLabelCountingLabel: ContentTypeJVLabelCountingLabel,
                initialText: String? = nil,
                numberOfLines: Int = 1) {
        self.contentTypeJVLabelCountingLabel = contentTypeJVLabelCountingLabel
        super.init(contentTypeId: contentTypeId, contentTypeTextFont: contentTypeTextFont, textAligment: textAligment, initialText: initialText, numberOfLines: numberOfLines)
    }
    
    public required init(old: ContentTypeJVLabel, newContentTypeId: String?) {
        super.init(old: old, newContentTypeId: newContentTypeId)
        
        contentTypeJVLabelCountingLabel = (old as? ContentTypeJVLabelTextCountingLabel)?.contentTypeJVLabelCountingLabel.copy()
    }
}

