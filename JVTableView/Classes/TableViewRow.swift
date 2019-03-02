import UIKit
import JVNoParameterInitializable
import JVTappable
import os
import JVConstraintEdges

open class TableViewRow: Tappable, Hashable {
    
    public static let defaultRowIdentifier = ""
    public static let edges = ConstraintEdges(height: 15, width: 15)
    
    // Determine if this cell should appear in the table view.
    open var showInTableView: (() -> (Bool)) = { return true }
    
    public private (set) var classType: TableViewCell.Type
    public private (set) var classIdentifier: String
    
    // When the cell is selectable, the closure inside here will be executed.
    public var tapped: (() -> ())?
    
    /// Some rows have some properties that the implemeting UIViewController needs access to.
    /// Therefore, we allow a customization poimt up to the developer when this property is set to true.
    /// This is only allowed on direct subclasses of UITableViewRow and which aren't standard cells.
    let updateUnsafely: Bool
    
    // By setting an identifier, it can be retrieved through the datasource again to query e.g. the value.
    let identifier: String
    
    // Determines if this cell should be selectable.
    // If set to true, it MUST have a tappable action (else the app will crash).
    var isSelectable = false
    let showViewControllerOnTap: UIViewControllerNoParameterInitializable?
    
    public init<T: RawRepresentable>(classType: TableViewCell.Type, identifier: T, showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, updateUnsafely: Bool = false, tapped: (() -> ())? = nil) {
        self.classType = classType
        self.classIdentifier = String(describing: identifier.rawValue)
        self.identifier = String(describing: identifier.rawValue)
        self.showViewControllerOnTap = showViewControllerOnTap
        self.tapped = tapped
        self.updateUnsafely = updateUnsafely
        
        assert(tapped == nil ? true : showViewControllerOnTap == nil)
    }
    
    public init(cell: JVTableViewStdCell, rawIdentifier: String = TableViewRow.defaultRowIdentifier, showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, updateUnsafely: Bool = false, tapped: (() -> ())? = nil) {
        self.classType = cell.classType
        self.classIdentifier = String(describing: classType)
        self.identifier = rawIdentifier
        self.showViewControllerOnTap = showViewControllerOnTap
        self.tapped = tapped
        self.updateUnsafely = updateUnsafely
        
        assert(tapped == nil ? true : showViewControllerOnTap == nil)
    }
    
    // Some custom rows doesn't want identifiers
    // Removing the T type omits generic errors.
    public init(classType: TableViewCell.Type, rawIdentifier: String = TableViewRow.defaultRowIdentifier, updateUnsafely: Bool = false, tapped: (() -> ())? = nil) {
        self.classType = classType
        self.classIdentifier = String(describing: classType)
        self.tapped = tapped
        self.identifier = rawIdentifier
        self.showViewControllerOnTap = nil
        self.updateUnsafely = updateUnsafely
    }
    
    init<T: RawRepresentable>(cell: JVTableViewStdCell, identifier: T, showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, updateUnsafely: Bool = false, tapped: (() -> ())? = nil) {
        self.classType = cell.classType
        self.classIdentifier = String(describing: identifier.rawValue)
        self.identifier = String(describing: identifier.rawValue)
        self.showViewControllerOnTap = showViewControllerOnTap
        self.tapped = tapped
        self.updateUnsafely = updateUnsafely
        
        assert(tapped == nil ? true : showViewControllerOnTap == nil)
    }
    
    public static func == (lhs: TableViewRow, rhs: TableViewRow) -> Bool {
        guard lhs.identifier != TableViewRow.defaultRowIdentifier && rhs.identifier != TableViewRow.defaultRowIdentifier else {
            return false
        }
        
        return lhs.identifier == rhs.identifier
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
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
