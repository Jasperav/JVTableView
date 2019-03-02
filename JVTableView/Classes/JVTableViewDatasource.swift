import UIKit
import JVNoParameterInitializable

open class JVTableViewDatasource: NoParameterInitializable {
    public var dataSource = [TableViewSection]()
    
    private (set) var dataSourceVisibleRows = [TableViewSection]()
    
    public required init() {
        createSections()
    }
    
    func determineSectionsWithVisibleRows() {
        dataSourceVisibleRows = dataSource.filter { $0.rows.filter { $0.showInTableView() }.count > 0 }
    }
    
    /// Must be overridden.
    /// This is the starting point when creating sections and rows.
    open func createSections() {
        fatalError() // Loop over all the sections.
    }
    
    open func determineHeaderImage() -> JVTableViewHeaderImage? {
        return nil
    }
    
    open func determineStyle() -> UITableView.Style {
        return .grouped
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
    
//    // Call this in your viewDidDisappear
//    public func clean() {
//        for section in dataSource {
//            for row in section.rows {
//                row.showInTableView = { return true }
//            }
//        }
//    }
//
//
//    public func getRow<T: RawRepresentable>(_ identifier: T) -> TableViewRow where T.RawValue == String {
//        return getRow(identifier.rawValue)
//    }
//
//
//    public func removeRow(_ identifier: String) {
//        for section in dataSource {
//            for (index, row) in section.rows.enumerated() {
//                guard row.identifier == identifier else { continue }
//                // TODO: The section needs to be removed as well if it doesn't contain a row anymore.
//                section.rows.remove(at: index)
//                return
//            }
//        }
//
//        fatalError()
//    }
//
//    public func getText(_ identifier: String) -> String {
//        let row = getRow(identifier) as! TableViewRowTextField
//
//        return row.currentValue
//    }
//
//    public func getBool(_ identifier: String) -> Bool {
//        let row = getRow(identifier) as! TableViewRowLabelSwitch
//
//        return row.currentValue
//    }
    
}
