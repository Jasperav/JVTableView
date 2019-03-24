import JVConstraintEdges

public class TableViewCellLabelWithDetail: TableViewCellLabel {
    public let labelDetail = UILabel(frame: .zero)
    
    public override var trailingView: UIView? {
        return labelDetail
    }

    public override func setup() {
        super.setup()
        
        // Resetting this to 1 ensures us the height of the 'normal' label doesn't shrink
        //labelDetail.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
    }
}
