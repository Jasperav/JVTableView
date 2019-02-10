import JVView
import JVConstraintEdges
import JVNoParameterInitializable

open class TableViewRowText: TableViewRow {
    public static var standardContentTypeJVLabel: ContentTypeJVLabelText!
    
    public var accessoryType: UITableViewCell.AccessoryType
    public var contentTypeJVLabel: ContentTypeJVLabelText
    public var _text: String? = nil
    
    public init(classType: TableViewCell.Type, identifier: String = "", accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator, contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowText.standardContentTypeJVLabel, text: String? = nil, showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) {
        self.accessoryType = accessoryType
        self.contentTypeJVLabel = contentTypeJVLabel.copy(contentTypeId: nil)
        self._text = text
        
        super.init(classType: classType, identifier: identifier, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
    }
    
    public init(cell: JVTableViewStdCell, identifier: String = "", accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator, contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowText.standardContentTypeJVLabel, text: String? = nil, showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) {
        self.accessoryType = accessoryType
        self.contentTypeJVLabel = contentTypeJVLabel.copy(contentTypeId: nil)
        self._text = text
        
        super.init(cell: cell, identifier: identifier, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
    }
    
    open override func configure(cell: TableViewCell) {
        cell.accessoryType = accessoryType
        
        update(cell: cell)
    }
    
    open func update(cell: TableViewCell) {
        fatalError()
    }
}
