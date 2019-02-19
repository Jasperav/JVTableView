public struct TableViewRowTapHandler {
    public let identifier: String
    
    let row: TableViewRow
    
    private (set) var addedTapHandler = false
    
    init(row: TableViewRow) {
        self.identifier = row.identifier
        self.row = row
    }
    
    public mutating func add(tapHandler: @escaping (() -> ())) {
        assert(!addedTapHandler)
        
        row.tapped = tapHandler
        
        addedTapHandler = true
    }
}
