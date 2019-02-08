import UIKit
import JVView
import JVConstraintEdges

open class TableViewCellLabel: TableViewCell {
    
    open var edges = ConstraintEdges(height: 15, width: 15)
    
    // We use a UILabel here because we need to update the label as a whole.
    public let label = UILabel(frame: CGRect.zero)
    
    open override func setup() {
        var edges = self.edges
        
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
            label.leadingAnchor.constraint(equalTo: _leadingView.trailingAnchor, constant: self.edges.leading!).isActive = true
        }
        
        if let _trailingView = trailingView, accessoryView != _trailingView {
            label.trailingAnchor.constraint(equalTo: _trailingView.leadingAnchor, constant: -self.edges.trailing!).isActive = true
        }
    }
    
    open func update(contentTypeJVLabelText: ContentTypeJVLabelText,
                     accessoryType: UITableViewCell.AccessoryType = .none,
                     text: String? = nil) {
        updateLabel(contentTypeJVLabelText: contentTypeJVLabelText, text: text)
        
        self.accessoryType = accessoryType
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
