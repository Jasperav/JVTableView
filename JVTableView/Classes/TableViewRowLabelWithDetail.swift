import JVView

public class TableViewRowLabelWithDetail: TableViewRowLabel {
    
    public static var contentTypeJVLabelDetail: ContentTypeJVLabelText!
    
    public var detailText: String? = nil
    
    public init(identifier: String = "",
                text: String? = nil,
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                detailText: String? = nil,
                contentTypeJVLabelDetail: ContentTypeJVLabelText = TableViewRowLabelWithDetail.standardContentTypeJVLabel,
                isSelectable: Bool = false,
                accessoryType: UITableViewCell.AccessoryType = .none,
                image: UIImage) {
        
        self.detailText = detailText
        
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, isSelectable: isSelectable, accessoryType: accessoryType)
        
        classIdentifier = JVTableViewStdCell.labelDetail.rawValue
    }
    public override func isVisible(_ cell: TableViewCellLabel) {
        let _cell = cell as! TableViewCellLabelWithDetail
        
        _cell.labelDetail.text = detailText

        super.isVisible(cell)
    }
}
