import UIKit
import JVView

public struct JVTableViewHelper {
    public unowned let tableView: JVTableView
    
    func determineFooterView(text: String) -> UIView {
        let edges = tableView.options.footer.constraintEdges
        let view = UIView()
        let label = JVLabel(contentType: tableView.options.footer.contentTypeLabel)
        
        label.numberOfLines = 0
        label.text = text
        label.fill(toSuperview: view, edges: edges)
        
        return view
    }
    
    func registerDefaultCells() {
        var stdCells = Set<JVTableViewStdCell>()
        
        for section in tableView.jvDatasource.dataSource {
            for row in section.rows {
                guard let cell = JVTableViewStdCell(rawValue: row.classIdentifier), stdCells.insert(cell).inserted else { continue }
                
                registerCell(cell)
            }
        }
    }
    
    private func registerCell(_ cell: JVTableViewStdCell) {
        switch cell {
        case .textField:
            tableView.register(TableViewCellTextField.self,
                               forCellReuseIdentifier: cell.rawValue)
        case .label:
            tableView.register(TableViewCellLabel.self,
                               forCellReuseIdentifier: cell.rawValue)
        case .labelSwitch:
            tableView.register(TableViewCellLabelSwitch.self,
                               forCellReuseIdentifier: cell.rawValue)
        case .labelImage:
            tableView.register(TableViewCellLabelImage.self,
                               forCellReuseIdentifier: cell.rawValue)
        }
    }
}
