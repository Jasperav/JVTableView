import UIKit
import JVView
import JVConstraintEdges
import JVTableViewCellLayoutCreator

open class TableViewCellLabel: TableViewCell {
    
    // We use a UILabel here because we need to update the label as a whole.
    public let label = UILabel(frame: CGRect.zero)
    
    open var leadingView: UIView? {
        return nil
    }
    
    open var trailingView: UIView? {
        return nil
    }
    
    open override func setup() {
        let trailingView: UIView?
            
        if let _trailingView = self.trailingView, _trailingView != accessoryView {
            trailingView = _trailingView
        } else {
            trailingView = nil
        }

        TableViewCellLayoutCreator.create(toCell: self, middleView: label, leadingView: leadingView, trailingView: trailingView)
    }
    
    open func updateLabel(ContentTypeJVLabel: ContentTypeJVLabel, text: String? = nil) {
        label.font = ContentTypeJVLabel.contentTypeTextFont.font
        label.textColor = ContentTypeJVLabel.contentTypeTextFont.color
        label.text = text
    }
    
}
