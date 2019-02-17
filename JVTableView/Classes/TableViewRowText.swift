import JVView
import JVConstraintEdges
import JVNoParameterInitializable
import JVChangeableValue

open class TableViewRowText: TableViewRow {
    public static var standardContentTypeJVLabel: ContentTypeJVLabelText!
    
    public var accessoryType: UITableViewCell.AccessoryType
    public var contentTypeJVLabel: ContentTypeJVLabelText
    public var _text = ""
    
    public init<T: RawRepresentable>(classType: TableViewCell.Type, identifier: T? = nil, accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator, contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowText.standardContentTypeJVLabel, text: String = "", showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) where T.RawValue == String {
        self.accessoryType = accessoryType
        self.contentTypeJVLabel = contentTypeJVLabel.copy(contentTypeId: nil)
        self._text = text
        
        super.init(classType: classType, identifier: identifier, showViewControllerOnTap: showViewControllerOnTap, tapped: tapped)
    }
    
    public init<T: RawRepresentable>(cell: JVTableViewStdCell, identifier: T? = nil, accessoryType: UITableViewCell.AccessoryType = .disclosureIndicator, contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowText.standardContentTypeJVLabel, text: String = "", showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) where T.RawValue == String {
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
    
    open override func determineUpdateType() -> TableViewRowUpdateType {
        return .text(_text)
    }
}
