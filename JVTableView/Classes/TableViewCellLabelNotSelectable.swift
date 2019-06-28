//import JVView
//
//open class TableViewCellLabelNotSelectable: TableViewCellLabel {
//    
//    private let stackView = UIStackView(frame: .zero)
//    private let blockedLabel = UILabel(frame: .zero)
//    
//    open override var middleView: UIView {
//        return stackView
//    }
//    
//    open override func setup() {
//        super.setup()
//        // TODO: JVStackView
//        stackView.axis = .vertical
//        stackView.spacing = 2
//        
//        stackView.addArrangedSubview(label)
//    }
//    
//    func change(state: TableViewRowLabelNotSelectable.State, contentTypeJVLabel: ContentTypeJVLabel, text: String? = nil) {
//        switch state {
//        case .selectable:
//            blockedLabel.removeFromSuperview()
//        case .notSelectable:
//            stackView.addArrangedSubview(blockedLabel)
//            blockedLabel.font = contentTypeJVLabel.contentTypeTextFont.font
//            blockedLabel.textColor = contentTypeJVLabel.contentTypeTextFont.color
//            blockedLabel.text = text
//        }
//    }
//}
