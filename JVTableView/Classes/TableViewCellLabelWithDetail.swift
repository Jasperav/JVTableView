import JVConstraintEdges

public class TableViewCellLabelWithDetail: TableViewCellLabel {
    public let labelDetail = UILabel(frame: .zero)
    
    public override func setup() {
        let edges = self.edges.min(.left)

        labelDetail.fill(toSuperview: contentView, edges: edges)
        
        super.setup()
        
        label.trailingAnchor.constraint(greaterThanOrEqualTo: labelDetail.leadingAnchor, constant: 5).isActive = true
    }
    
    public override func determineLeadingView() -> UIView? {
        return labelDetail
    }
}
