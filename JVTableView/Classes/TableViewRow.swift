import UIKit

open class TableViewRow {
    
    // The identifier of the cell CLASS.
    public let classIdentifier: String
    
    // Will be called by JVTableView when the cell has appeared on the screen.
    open var isVisible: ((_ cell: UITableViewCell) -> ())?
    
    // By setting an identifier, it can be retrieved through the datasource again to query e.g. the value.
    public let identifier: String
    
    // Determine if this cell should appear in the table view.
    open var showInTableView: (() -> (Bool))?
    
    // Determines if this cell should be selectable.
    // If set to true, it MUST have a tappable action (else the app will crash).
    public var isSelectable = false
    
    public init(cellIdentifier: String, isVisible: ((_ cell: UITableViewCell) -> ())? = nil, identifier: String = "") {
        self.classIdentifier = cellIdentifier
        self.isVisible = isVisible
        self.identifier = identifier
    }
    
    public init(cell: JVTableViewStdCell, isVisible: ((_ cell: UITableViewCell) -> ())? = nil, identifier: String = "") {
        self.classIdentifier = cell.rawValue
        self.isVisible = isVisible
        self.identifier = identifier
    }
}
