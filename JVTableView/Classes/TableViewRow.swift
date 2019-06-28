import UIKit
import JVNoParameterInitializable
import os
import JVConstraintEdges

open class TableViewRow: Hashable {
    
    public static let defaultRowIdentifier = ""
    public static let edges = ConstraintEdges(height: 15, width: 15)
    
    // Determine if this cell should appear in the table view.
    open var isVisible: (() -> (Bool)) = { return true }
    open var classType: TableViewCell.Type {
        fatalError()
    }
    
    public private (set) var classIdentifier = TableViewRow.defaultRowIdentifier
    
    /// Get's called inside the didSelectRowAt
    var _tapped: (() -> ())?
    
    // When the cell is selectable and _tapped == nil, the closure inside here will be executed.
    public var tapped: ((UIViewController) -> ())?
    
    // Possibility to save the row directly, without using the ViewController.
    public var save: (() -> ())? = nil
    
    public var accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
    
    /// Some rows have some properties that the implementing UIViewController needs access to.
    /// Therefore, we allow a customization poimt up to the developer when this property is set to true.
    /// This is only allowed on direct subclasses of UITableViewRow and which aren't standard cells.
    public var updateUnsafely = false
    
    // By setting an identifier, it can be retrieved through the datasource again to query e.g. the value.
    public let identifier: String

    // Determines if this cell should be selectable.
    // If set to true, it MUST have a tappable action (else the app will crash).
    public var isSelectable: (() -> (Bool)) = { return true }
    
    public var showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil
    
    public init<T: RawRepresentable>(identifier: T) {
        self.identifier = String(describing: identifier.rawValue)
    }
    
    public init(rawIdentifier: String = TableViewRow.defaultRowIdentifier) {
        self.identifier = rawIdentifier
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
    
    /// Call super.configure as the last expression when overriding this method.
    open func configure(cell: TableViewCell) {
        if isSelectable() {
            // Cell can be selected again
            cell.accessoryType = accessoryType
            makeSelectable(cell: cell)
        } else {
            // Cell became unclickable
            cell.accessoryType = .none
            makeUnselectable(cell: cell)
        }
    }
    
    /// Called after the cell was unselectable, but is now selectable again.
    open func makeSelectable(cell: TableViewCell) {
        
    }
    
    /// Called after the cell was selectable, but now isn't anymore.
    open func makeUnselectable(cell: TableViewCell) {
        
    }
    
    #if DEBUG
    open func validate() {
        assert(tapped == nil ? true : showViewControllerOnTap == nil)
        if accessoryType == .none {
            assert(!isSelectable())
        }
        assert(showViewControllerOnTap == nil ? true : isSelectable())
        assert(classIdentifier != TableViewRow.defaultRowIdentifier)
    }
    #endif
    
    open func commonLoad() {
        classIdentifier = String(describing: classType)
        
        if isSelectable() && tapped == nil && showViewControllerOnTap == nil {
            assert(identifier != TableViewRow.defaultRowIdentifier, "You must be able to access the unsafe updateable rows by property.")
            updateUnsafely = true
        }
    }
}
