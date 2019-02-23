import JVView
import JVConstraintEdges
import JVNoParameterInitializable
import JVChangeableValue

open class TableViewRowText: TableViewRow {
    public static var standardContentTypeJVLabel: ContentTypeJVLabelText!
    
    public var accessoryType: UITableViewCell.AccessoryType
    public var contentTypeJVLabel: ContentTypeJVLabelText
    public var _text = ""
    
    public init<T: RawRepresentable>(classType: TableViewCell.Type, identifier: T, accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator, contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowText.standardContentTypeJVLabel, text: String = "", showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) {
        self.accessoryType = accessoryType
        self.contentTypeJVLabel = contentTypeJVLabel.copy(contentTypeId: nil)
        self._text = text
        
        super.init(classType: classType, identifier: identifier, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
    }
    
    public init<T: RawRepresentable>(cell: JVTableViewStdCell, identifier: T, accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator, contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowText.standardContentTypeJVLabel, text: String = "", showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) {
        self.accessoryType = accessoryType
        self.contentTypeJVLabel = contentTypeJVLabel.copy(contentTypeId: nil)
        self._text = text
        
        super.init(cell: cell, identifier: identifier, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
    }
    
    public init(cell: JVTableViewStdCell, rawIdentifier: String = TableViewRow.defaultRowIdentifier, accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator, contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowText.standardContentTypeJVLabel, text: String = "", showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil)  {
        self.accessoryType = accessoryType
        self.contentTypeJVLabel = contentTypeJVLabel.copy(contentTypeId: nil)
        self._text = text
        
        super.init(cell: cell, rawIdentifier: rawIdentifier, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
        
        assert(rawIdentifier == TableViewRow.defaultRowIdentifier ? _text != "" : true)
    }
    
    open override func configure(cell: TableViewCell) {
        cell.accessoryType = accessoryType
        
        update(cell: cell)
    }
    
    open func update(cell: TableViewCell) {
        fatalError()
    }
    
    open override func determineUpdateType() -> TableViewRowUpdateType {
        return .text(_text)
    }
}
