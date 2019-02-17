import JVView
import JVNoParameterInitializable

public class TableViewRowLabelWithDetail: TableViewRowLabel {
    
    public static var contentTypeJVLabelDetail: ContentTypeJVLabelText!
    
    public var detailText: String? = nil
    public var contentTypeJVLabelDetail: ContentTypeJVLabelText
    
    public init<T: RawRepresentable>(identifier: T,
                                     text: String = "",
                                     contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                                     detailText: String? = nil,
                                     contentTypeJVLabelDetail: ContentTypeJVLabelText = TableViewRowLabelWithDetail.contentTypeJVLabelDetail,
                                     accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator, showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) where T.RawValue == String {
        
        self.detailText = detailText
        self.contentTypeJVLabelDetail = contentTypeJVLabelDetail
        
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: accessoryType, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
    }
    
    public init(rawIdentifier: String = TableViewRow.defaultRowIdentifier,
                text: String = "",
                contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel,
                detailText: String? = nil,
                contentTypeJVLabelDetail: ContentTypeJVLabelText = TableViewRowLabelWithDetail.contentTypeJVLabelDetail,
                accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator, showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) {
        
        self.detailText = detailText
        self.contentTypeJVLabelDetail = contentTypeJVLabelDetail
        
        super.init(rawIdentifier: rawIdentifier, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: accessoryType, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
        
        commonLoad()
    }
    
    
    private func commonLoad() {
        changeClassType(cell: JVTableViewStdCell.labelDetail)
    }
    
    public override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellLabelWithDetail
        
        _cell.labelDetail.text = detailText
        _cell.labelDetail.font = contentTypeJVLabelDetail.contentTypeTextFont.font
        _cell.labelDetail.textColor = contentTypeJVLabelDetail.contentTypeTextFont.color
        
        super.configure(cell: cell)
    }
    
}
