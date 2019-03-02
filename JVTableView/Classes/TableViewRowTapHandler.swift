// Class rather than a struct, else we need to change the array everytime with ugly indexes...
public class TableViewTapHandler<T: TableViewRow>: Hashable {
    public static func == (lhs: TableViewTapHandler<T>, rhs: TableViewTapHandler<T>) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    public let identifier: String
    
    let row: T
    
    fileprivate (set) var addedTapHandler = false
    
    init(row: T) {
        self.identifier = row.identifier
        self.row = row
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

}

public class TableViewRowTapHandler: TableViewTapHandler<TableViewRow> {
    public func add(tapHandler: @escaping (() -> ())) {
        assert(!addedTapHandler)
        
        row.tapped = tapHandler
        
        addedTapHandler = true
    }
}

public class TableViewRowLabelImageRightButtonTapHandler: TableViewTapHandler<TableViewRowLabelImageAndButton> {
    
    public func add(tapHandler: @escaping ((TableViewCellLabelImageAndButton) -> ())) {
        assert(!addedTapHandler)
        
        row.tappedRightButton = tapHandler
        
        addedTapHandler = true
    }
}
