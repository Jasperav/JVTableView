import UIKit
import JVView
import JVConstraintEdges

open class TableViewCellLabel: UITableViewCell {
    
    open var edges = ConstraintEdges(height: 15, width: 15)
    
    // We use a UILabel here because we need to update the label as a whole.
    public let label = UILabel(frame: CGRect.zero)
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setup() {
        var edges = self.edges
        
        let leadingView = determineLeadingView()
        let trailingView = determineTrailingView()
        
        if leadingView != nil {
            edges.minus(edge: .left)
        }
        
        if trailingView != nil {
            edges.minus(edge: .right)
        }
        
        label.fill(toSuperview: contentView, edges: edges)
        
        if let _leadingView = leadingView {
            label.leadingAnchor.constraint(equalTo: _leadingView.trailingAnchor, constant: self.edges.leading!).isActive = true
        }
        
        if let _trailingView = trailingView {
            label.trailingAnchor.constraint(equalTo: _trailingView.leadingAnchor, constant: -self.edges.trailing!).isActive = true
        }
    }
    
    open func update(options: JVLabelCellOptions, text: String? = nil) {
        updateLabel(contentTypeJVLabelText: options.contentTypeJVLabelText, text: text)
        
        assert(options.accessoryType != .none
            ? type(of: self) == TableViewCellLabel.self
            : true)
        
        accessoryType = options.accessoryType
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
