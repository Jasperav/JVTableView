import JVView
import JVConstraintEdges

open class TableViewCellButton: TableViewCell {
    
    open var edges = ConstraintEdges(height: 15, width: 15)
    
    public let button = UIButton(type: .system)
    
    open override func setup() {
        button.fill(toSuperview: contentView, edges: edges)
    }
    
    open func update(contentTypeJVLabelText: ContentTypeJVLabelText,
                     text: String? = nil) {
        button.setTitle(text, for: .normal)
        button.titleLabel!.font = contentTypeJVLabelText.contentTypeTextFont.font
    }
    
}
