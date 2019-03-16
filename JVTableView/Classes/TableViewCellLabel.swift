import UIKit
import JVView
import JVConstraintEdges
import JVTableViewCellLayoutCreator

open class TableViewCellLabel: TableViewCell {
    
    // We use a UILabel here because we need to update the label as a whole.
    public let label = UILabel(frame: CGRect.zero)
    
    open override func setup() {
        let leadingView = determineLeadingView()
        let trailingView: UIView?
            
        if let _trailingView = determineTrailingView(), _trailingView != accessoryView {
            trailingView = _trailingView
        } else {
            trailingView = nil
        }

        TableViewCellLayoutCreator.create(middleView: label, toCell: self, innerContentViewEdges: TableViewCell.edges, leadingView: leadingView, trailingView: trailingView)
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
