import UIKit
import JVNoParameterInitializable

open class JVTableViewDatasource: NoParameterInitializable {
    open var headerImage: JVTableViewHeaderImage? {
        return nil
    }
    
    open var style: UITableView.Style {
        return .grouped
    }
    
    public var dataSource = [TableViewSection]()
    
    private (set) var dataSourceVisibleRows = [TableViewSection]()
    
    public required init() {
        createSections()
    }
    
    func updateVisibleRows() {
        dataSourceVisibleRows = dataSource.filter { $0.rows.filter { $0.showInTableView() }.count > 0 }
    }
    
    /// Must be overridden.
    /// This is the starting point when creating sections and rows.
    open func createSections() {
        fatalError() // Loop over all the sections.
    }
    
    func getRow(_ indexPath: IndexPath) -> TableViewRow {
        return getSection(indexPath.section).rows[indexPath.row]
    }
    
    func getSection(_ indexPath: IndexPath) -> TableViewSection {
        return getSection(indexPath.section)
    }
    
    func getSection(_ section: Int) -> TableViewSection {
        return dataSourceVisibleRows[section]
    }
    
    public func getRow(_ identifier: String) -> TableViewRow {
        for section in dataSource {
            for row in section.rows {
                guard row.identifier == identifier else { continue }
                return row
            }
        }
        
        fatalError()
    }
    
}
