import JVContentType

open class ContentTypeJVLabelAttributedTextCountingLabel: ContentTypeJVLabelAttributedText {
    public var contentTypeJVLabelCountingLabel: ContentTypeJVLabelCountingLabel!
    
    public init(contentTypeId: String?, contentTypeAttributedTexts: [ContentTypeAttributedText], textAligment: NSTextAlignment = .natural, contentTypeTextFont: ContentTypeTextFont, contentTypeJVLabelCountingLabel: ContentTypeJVLabelCountingLabel, initialText: String? = nil, numberOfLines: Int = 1) {
        self.contentTypeJVLabelCountingLabel = contentTypeJVLabelCountingLabel
        
        super.init(contentTypeId: contentTypeId, contentTypeAttributedTexts: contentTypeAttributedTexts, textAligment: textAligment, initialText: initialText, numberOfLines: numberOfLines)
    }
    
    public required init(old: ContentTypeJVLabel, newContentTypeId: String?) {
        super.init(old: old, newContentTypeId: newContentTypeId)
        
        contentTypeJVLabelCountingLabel = (old as? ContentTypeJVLabelAttributedTextCountingLabel)?.contentTypeJVLabelCountingLabel
    }
}

