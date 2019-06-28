import UIKit
import JVNoParameterInitializable

open class JVTableViewDatasource {
    open var headerImage: JVTableViewHeaderImage? {
        return nil
    }
    
    open var style: UITableView.Style {
        return .grouped
    }
    
    public var dataSource = [TableViewSection]()
    
    private (set) var dataSourceVisibleRows = [TableViewSection]()
    
    public init() {
        createSections()
    }
    
    func updateVisibleRows() {
        dataSourceVisibleRows.removeAll()
        
        for section in dataSource {
            let visibleRows = section.rows.filter { $0.isVisible() }
            
            guard !visibleRows.isEmpty else { continue } // Whole section is empty
            
            dataSourceVisibleRows.append(TableViewSection(header: section.header, footerText: section.footerText, rows: visibleRows))
        }
    }
    
    /// Customization point before reloading the datasource
    open func prepareForReload() { }
    
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
        return dataSource.map { $0.rows }
            .flatMap { $0 }
            .first(where: { $0.identifier == identifier })!
    }
    
    private func calculateIndexPath(identifier: String, array: [TableViewSection]) -> IndexPath {
        for (section, sectionElement) in array.enumerated() {
            for (row, rowElement) in sectionElement.rows.enumerated() {
                guard rowElement.identifier == identifier else { continue }
                
                return IndexPath(row: row, section: section)
            }
        }
        
        fatalError()
    }
    
    func indexPathForVisibleCell(identifier: String) -> IndexPath {
        calculateIndexPath(identifier: identifier, array: dataSourceVisibleRows)
    }
    
    func indexPath(identifier: String) -> IndexPath {
        calculateIndexPath(identifier: identifier, array: dataSource)
    }
}
