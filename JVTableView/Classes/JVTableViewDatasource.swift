import UIKit

public class JVTableViewDatasource {
    public var dataSource = [TableViewSection]()
    
    public init(dataSource: [TableViewSection] = []) {
        self.dataSource = dataSource
    }
    
    
    public func getRow(_ indexPath: IndexPath) -> TableViewRow {
        return getSection(indexPath.section).rows[indexPath.row]
    }
    
    public func getSection(_ indexPath: IndexPath) -> TableViewSection {
        return getSection(indexPath.section)
    }
    
    public func getSection(_ section: Int) -> TableViewSection {
        return dataSource[section]
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
    
//    public func getText(_ identifier: String) -> String {
//        let row = getRow(identifier) as! TableViewRowTextField
//        
//        return row.currentValue
//    }
//    
//    public func getBool(_ identifier: String) -> Bool {
//        let row = getRow(identifier) as! TableViewRowSwitch
//        
//        return row.currentValue
//    }
    
}
