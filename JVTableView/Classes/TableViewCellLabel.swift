import UIKit
import JVView
import JVConstraintEdges

open class TableViewCellLabel: TableViewCell {
    
    // We use a UILabel here because we need to update the label as a whole.
    public let label = UILabel(frame: CGRect.zero)
    
    open override func setup() {
        var edges = TableViewRow.edges
        
        let leadingView = determineLeadingView()
        let trailingView = determineTrailingView()
        
        if leadingView != nil {
            edges.minus(edge: .left)
        }
        
        if let _trailingView = trailingView, accessoryView != _trailingView {
            edges.minus(edge: .right)
        }
        
        label.fill(toSuperview: contentView, edges: edges)
        
        if let _leadingView = leadingView {
            label.leadingAnchor.constraint(equalTo: _leadingView.trailingAnchor, constant: TableViewRow.edges.leading!).isActive = true
        }
        
        if let _trailingView = trailingView, accessoryView != _trailingView {
            label.trailingAnchor.constraint(equalTo: _trailingView.leadingAnchor, constant: -TableViewRow.edges.trailing!).isActive = true
        }
    }
    
    open func determineLeadingView() -> UIView? {
        return nil
    }
    
    open func determineTrailingView() -> UIView? {
        return nil
    }
    
    open func updateLabel(contentTypeJVLabelText: ContentTypeJVLabelText, text: String? = nil) {
        label.font = contentTypeJVLabelText.contentTypeTextFont.font
        label.textColor = contentTypeJVLabelText.contentTypeTextFont.color
        label.text = text
    }
    
}
