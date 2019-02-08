import UIKit
import JVNoParameterInitializable
import JVTappable

open class TableViewRow: Tappable {
    
    public private (set) var classType: TableViewCell.Type
    public private (set) var classIdentifier: String
    
    // Will be called by JVTableView when the cell has appeared on the screen.
    open var isVisible: ((_ cell: UITableViewCell) -> ())?
    
    // By setting an identifier, it can be retrieved through the datasource again to query e.g. the value.
    public let identifier: String
    
    // Determine if this cell should appear in the table view.
    open var showInTableView: (() -> (Bool)) = { return true }
    
    // Determines if this cell should be selectable.
    // If set to true, it MUST have a tappable action (else the app will crash).
    public var isSelectable = false
    
    public var tapped: (() -> ())?
    
    public let showViewControllerOnTap: UIViewControllerNoParameterInitializable?
    
    public init(classType: TableViewCell.Type, isVisible: ((_ cell: UITableViewCell) -> ())? = nil, identifier: String = "", showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) {
        self.classType = classType
        self.classIdentifier = String(describing: classType)
        self.isVisible = isVisible
        self.identifier = identifier
        self.showViewControllerOnTap = showViewControllerOnTap
        self.tapped = tapped
        
        assert(tapped == nil ? true : showViewControllerOnTap == nil)
    }
    
    public init(cell: JVTableViewStdCell, isVisible: ((_ cell: UITableViewCell) -> ())? = nil, identifier: String = "", showViewControllerOnTap: UIViewControllerNoParameterInitializable? = nil, tapped: (() -> ())? = nil) {
        self.classType = cell.classType
        self.classIdentifier = String(describing: classType)
        self.isVisible = isVisible
        self.identifier = identifier
        self.showViewControllerOnTap = showViewControllerOnTap
        self.tapped = tapped
        
        assert(tapped == nil ? true : showViewControllerOnTap == nil)
    }
    
    public func change(classType: TableViewCell.Type) {
        self.classType = classType
        self.classIdentifier = String(describing: classType)
    }
    
    func changeClassType(cell: JVTableViewStdCell) {
        self.classType = cell.classType
        self.classIdentifier = String(describing: classType)
    }
}
