import JVConstraintEdges

public class TableViewCellLabelWithDetail: TableViewCellLabel {
    public let labelDetail = UILabel(frame: .zero)
    
    public override func configure() {
        var edges = self.edges.min(.left)
        
        edges.trailing = 5
        
        labelDetail.fill(toSuperview: contentView, edges: edges)
        labelDetail.setContentHuggingAndCompressionResistance(999)
        
        // Resetting this to 1 ensures us the height of the 'normal' label doesn't shrink
        labelDetail.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)

        super.configure()
    }
    
    public override func determineTrailingView() -> UIView? {
        return labelDetail
    }
}
