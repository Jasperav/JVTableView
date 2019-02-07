import UIKit
import JVView


// TODO: Remove?
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
}
