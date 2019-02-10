import JVView
import JVConstraintEdges
import JVCurrentDevice

open class TableViewCellButton: TableViewCell {
    
    public let button = UIButton(type: .system)
    
    open override func setup() {
        button.fill(toSuperview: contentView, edges: TableViewRow.edges)
        
        if CurrentDevice.isRightToLeftLanguage {
            button.contentHorizontalAlignment = .right
        } else {
            button.contentHorizontalAlignment = .left
        }
    }
    
    open func update(contentTypeJVLabelText: ContentTypeJVLabelText,
                     text: String? = nil) {
        button.setTitle(text, for: .normal)
        button.titleLabel!.font = contentTypeJVLabelText.contentTypeTextFont.font
    }
    
}
