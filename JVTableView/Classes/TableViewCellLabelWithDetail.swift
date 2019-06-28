import JVConstraintEdges
import JVView
// TODO: Import JVStackView

public class TableViewCellLabelWithDetail: TableViewCellLabel {

    let labelDetail = LoadableLabel(textSetup: TextSetup(), state: .load)
    let stackView = UIStackView(frame: .zero)
    
    public override var middleView: UIView {
        return stackView
    }

    public override func setup() {
        super.setup()
        
        stackView.spacing = 3 // TODO: Dynamic
        stackView.addArrangedSubview(label)
    }
}
