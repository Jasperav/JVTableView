import UIKit

open class JVTableViewDatasource {
    public var dataSource = [TableViewSection]()
    private (set) var dataSourceVisibleRows = [TableViewSection]()
    
    // Don't override.
    public init() {
        createSections()
    }
    
    open func createSections() {
        fatalError() // Loop over all the sections.
    }
    
    public func determineSectionsWithVisibleRows() {
        dataSourceVisibleRows = dataSource.filter { $0.rows.filter { $0.showInTableView() }.count > 0 }
    }
    
    // Call this in your viewDidDisappear
    public func clean() {
        for section in dataSource {
            for row in section.rows {
                row.showInTableView = { return true }
            }
        }
    }
    
    public func getRow(_ indexPath: IndexPath) -> TableViewRow {
        return getSection(indexPath.section).rows[indexPath.row]
    }
    
    public func getSection(_ indexPath: IndexPath) -> TableViewSection {
        return getSection(indexPath.section)
    }
    
    public func getSection(_ section: Int) -> TableViewSection {
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
    
    public func removeRow(_ identifier: String) {
        for section in dataSource {
            for (index, row) in section.rows.enumerated() {
                guard row.identifier == identifier else { continue }
                
                section.rows.remove(at: index)
                return
            }
        }
        
        fatalError()
    }
    
    public func getText(_ identifier: String) -> String {
        let row = getRow(identifier) as! TableViewRowTextField
        
        return row.currentValue
    }
    
    public func getBool(_ identifier: String) -> Bool {
        let row = getRow(identifier) as! TableViewRowLabelSwitch
        
        return row.currentValue
    }
    
}
