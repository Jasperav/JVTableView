import JVView
import JVConstraintEdges

open class TableViewCellButton: TableViewCell {
    
    public let button = UIButton(type: .system)
    
    open override func setup() {
        button.fill(toSuperview: contentView, edges: TableViewRow.edges)
    }
    
    open func update(contentTypeJVLabelText: ContentTypeJVLabelText,
                     text: String? = nil) {
        button.setTitle(text, for: .normal)
        button.titleLabel!.font = contentTypeJVLabelText.contentTypeTextFont.font
    }
    
}
