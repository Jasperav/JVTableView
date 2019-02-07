import JVView
import JVNoParameterInitializable

public class TableViewRowLabelWithDetail: TableViewRowLabel {
    
    public static var contentTypeJVLabelDetail: ContentTypeJVLabelText!
    
    public var detailText: String? = nil
    public var contentTypeJVLabelDetail: ContentTypeJVLabelText
    
    public init(identifier: String = "",
                text: String? = nil,
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                detailText: String? = nil,
                contentTypeJVLabelDetail: ContentTypeJVLabelText = TableViewRowLabelWithDetail.contentTypeJVLabelDetail,
                isSelectable: Bool = false,
                accessoryType: UITableViewCell.AccessoryType = .none, showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) {
        
        self.detailText = detailText
        self.contentTypeJVLabelDetail = contentTypeJVLabelDetail
        
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, isSelectable: isSelectable, accessoryType: accessoryType, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
        
        classIdentifier = JVTableViewStdCell.labelDetail.rawValue
    }
    public override func isVisible(_ cell: TableViewCellLabel) {
        let _cell = cell as! TableViewCellLabelWithDetail
        
        _cell.labelDetail.text = detailText
        _cell.labelDetail.font = contentTypeJVLabelDetail.contentTypeTextFont.font
        _cell.labelDetail.textColor = contentTypeJVLabelDetail.contentTypeTextFont.color

        super.isVisible(cell)
    }
}
