import UIKit
import JVNoParameterInitializable
import JVTappable
import os
import JVConstraintEdges

func determine<T: RawRepresentable>(identifier: T?) -> String where T.RawValue == String {
    return identifier?.rawValue ?? TableViewRow.defaultRowIdentifier
}

open class TableViewRow: Tappable {
    
    public static let defaultRowIdentifier = ""
    public static let edges = ConstraintEdges(height: 15, width: 15)
    
    public private (set) var classType: TableViewCell.Type
    public private (set) var classIdentifier: String
    
    // By setting an identifier, it can be retrieved through the datasource again to query e.g. the value.
    public let identifier: String
    
    // Determine if this cell should appear in the table view.
    open var showInTableView: (() -> (Bool)) = { return true }
    
    // Determines if this cell should be selectable.
    // If set to true, it MUST have a tappable action (else the app will crash).
    public var isSelectable = false
    
    // When the cell is selectable, the closure inside here will be executed.
    public var tapped: (() -> ())?
    
    public let showViewControllerOnTap: UIViewControllerNoParameterInitializable?
    
    public init<T: RawRepresentable>(classType: TableViewCell.Type, identifier: T? = nil, showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) where T.RawValue == String {
        self.classType = classType
        self.classIdentifier = String(describing: classType)
        self.identifier = determine(identifier: identifier)
        self.showViewControllerOnTap = showViewControllerOnTap
        self.tapped = tapped
        
        assert(tapped == nil ? true : showViewControllerOnTap == nil)
    }
    
    public init<T: RawRepresentable>(cell: JVTableViewStdCell, identifier: T? = nil, showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) where T.RawValue == String {
        self.classType = cell.classType
        self.classIdentifier = String(describing: classType)
        self.identifier = determine(identifier: identifier)
        self.showViewControllerOnTap = showViewControllerOnTap
        self.tapped = tapped
        
        assert(tapped == nil ? true : showViewControllerOnTap == nil)
    }
    
    // Some custom rows doesn't want identifiers
    public convenience init(classType: TableViewCell.Type, identifier: String? = nil) {
        self.init(classType: classType, identifier: identifier, showViewControllerOnTap: nil, tapped: nil)
    }
    
    public func change(classType: TableViewCell.Type) {
        self.classType = classType
        self.classIdentifier = String(describing: classType)
    }
    
    open func configure(cell: TableViewCell) {
        #if DEBUG
        // Let the app crash when a standard cell hasn't been configured.
        let forbiddenClassTypes = JVTableViewStdCell.allCases.map { $0.classType }
        let currentCellType = type(of: cell)
        
        assert(!forbiddenClassTypes.contains(where: { $0 == currentCellType }))
        #endif
    }
    
    // Will be called when 'self' is changeable and the data from the tableView will be saved.
    open func determineUpdateType() -> TableViewRowUpdateType {
        fatalError()
    }
    
    func changeClassType(cell: JVTableViewStdCell) {
        self.classType = cell.classType
        self.classIdentifier = String(describing: classType)
    }
}

extension String: RawRepresentable {
    public var rawValue: String {
        return self
    }
    
    public init?(rawValue: String) {
        self.init(stringLiteral: rawValue)
    }
}
