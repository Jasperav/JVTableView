// Class rather than a struct, else we need to change the array everytime with ugly indexes...
public class TableViewRowTapHandler {
    public let identifier: String
    
    let row: TableViewRow
    
    private (set) var addedTapHandler = false
    
    init(row: TableViewRow) {
        self.identifier = row.identifier
        self.row = row
    }
    
    public func add(tapHandler: @escaping (() -> ())) {
        assert(!addedTapHandler)
        
        row.tapped = tapHandler
        
        addedTapHandler = true
    }
}
