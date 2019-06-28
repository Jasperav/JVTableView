//import JVView
//import JVNoParameterInitializable
//
//open class TableViewRowLabelNotSelectable: TableViewRowLabel {
//    
//    public static var contentTypeBlockedLabel: ContentTypeJVLabel!
//    
//    public enum State {
//        case selectable, notSelectable
//    }
//    
//    var state = State.selectable
//    
//    private let textBlockedLabel: String
//    private let contentTypeBlockedLabel: ContentTypeJVLabel
//    
//    public init<T: RawRepresentable>(identifier: T,
//                                     textBlockedLabel: String,
//                                     text: String = "",
//                                     contentTypeJVLabel: ContentTypeJVLabel = TableViewRowText.standardContentTypeJVLabel,
//                                     contentTypeBlockedLabel: ContentTypeJVLabel = TableViewRowLabelNotSelectable.contentTypeBlockedLabel,
//                                     accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator,
//                                     showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil,
//                                     tapped: (() -> ())? = nil) {
//        self.textBlockedLabel = textBlockedLabel
//        self.contentTypeBlockedLabel = contentTypeBlockedLabel
//        
//        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: accessoryType, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped, type: .labelNotSelectable)
//    }
//    
//    open override func update(cell: TableViewCell) {
//        super.update(cell: cell)
//        
//        let _cell = (cell as! TableViewCellLabelNotSelectable)
//        
//        switch state {
//        case .selectable:
//            _cell.accessoryType = accessoryType
//            isSelectable = true
//        case .notSelectable:
//            _cell.accessoryType = .none
//            isSelectable = false
//            _cell.label.textColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
//        }
//        
//        _cell.change(state: state, contentTypeJVLabel: contentTypeBlockedLabel, text: textBlockedLabel)
//    }
//
//}
