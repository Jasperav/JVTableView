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
        
        if let leadingView = leadingView {
            assert(leadingView.superview == nil)
            
            leadingView.fill(toSuperview: contentView, edges: ConstraintEdges(leading: TableViewRow.edges.leading!))
            
            label.leadingAnchor.constraint(equalTo: leadingView.trailingAnchor, constant: TableViewRow.edges.leading!).isActive = true
            
            addLeadingOrTrailingView(view: leadingView)
        }
        
        if let trailingView = trailingView, accessoryView != trailingView {
            assert(trailingView.superview == nil)
            
            trailingView.fill(toSuperview: contentView, edges: ConstraintEdges(trailing: TableViewRow.edges.trailing!))
            
            label.trailingAnchor.constraint(equalTo: trailingView.leadingAnchor, constant: -TableViewRow.edges.trailing!).isActive = true
            
            addLeadingOrTrailingView(view: trailingView)
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
    
    private func addLeadingOrTrailingView(view: UIView) {
        view.equal(to: label, height: true, width: false)
        view.setSameCenterY(view: label)
    }
    
}
