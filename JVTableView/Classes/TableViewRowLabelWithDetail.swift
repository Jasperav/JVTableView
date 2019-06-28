import JVView
import JVNoParameterInitializable

/// Stackview with 2 labels.
public class TableViewRowLabelWithDetail: TableViewRowLabel {
    
    open override var classType: TableViewCell.Type {
        return TableViewCellLabelWithDetail.self
    }
    
    public enum State {
        case alwaysShowDetailLabel, onlyShowWhenNotSelectable, dynamic(() -> (Bool))
    }
    
    public var labelSetupDetail = TextSetup(font: .caption2, color: .systemGray)
    public var axis = NSLayoutConstraint.Axis.vertical
    public let detailText: (() -> (String?))
    
    // If nil, showDetailLabel will determine if the detail label will be shown.
    public var state = State.alwaysShowDetailLabel
    
    public init(text: String,
                detailText: @escaping (() -> (String?))) {
        self.detailText = detailText
        
        super.init(text: text)
    }
    
    public convenience init(text: String,
                detailText: String) {
        self.init(text: text, detailText: {
            return detailText
        })
    }
    
    public init<T: RawRepresentable>(
        identifier: T,
        text: String,
        detailText: String) {
        self.detailText = { return detailText }
        
        super.init(identifier: identifier, text: text)
    }
    
    public override func configure(cell: TableViewCell) {
        super.configure(cell: cell)
        
        let _cell = cell as! TableViewCellLabelWithDetail
        
        _cell.stackView.axis = axis
        
        let showDetailLabel: Bool
        
        switch state {
        case .alwaysShowDetailLabel:
            showDetailLabel = true
        case .onlyShowWhenNotSelectable:
            showDetailLabel = !isSelectable()
        case .dynamic(let shouldShow):
            showDetailLabel = shouldShow()
        }
        
        if showDetailLabel {
            addLabelDetailView(cell: _cell)
        } else {
            _cell.labelDetail.removeFromSuperview()
        }
    }
    
    private func addLabelDetailView(cell: TableViewCellLabelWithDetail) {
        if cell.labelDetail.superview == nil {
            cell.stackView.addArrangedSubview(cell.labelDetail)
        }
        
        cell.labelDetail.label.update(setup: labelSetupDetail)
        cell.labelDetail.change(text: detailText())
        
        switch cell.stackView.axis {
        case .horizontal:
            cell.labelDetail.label.numberOfLines = 1
        case .vertical:
            cell.labelDetail.label.numberOfLines = 0
        }
    }
}
