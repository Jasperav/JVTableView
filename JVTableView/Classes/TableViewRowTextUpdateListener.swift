public protocol RowUpdater {
    associatedtype V
    associatedtype R: TableViewRow
    
    var rowIdentifier: String { get }
    var value: V { get }
    
    func update(row: R)
}

public struct TableViewRowTextUpdate: RowUpdater {

    public typealias R = TableViewRowText
    
    public let rowIdentifier: String
    public let value: String
    
    public init<T: RawRepresentable>(rowIdentifier: T, value: String) where T.RawValue == String {
        self.rowIdentifier = rowIdentifier.rawValue
        self.value = value
    }
    
    public func update(row: TableViewRowText) {
        row._text = value
    }
}

public struct TableViewRowTextFieldUpdate: RowUpdater {
    
    public typealias R = TableViewRowTextField
    
    public let rowIdentifier: String
    public let value: String
    
    public init<T: RawRepresentable>(rowIdentifier: T, value: String) where T.RawValue == String {
        self.rowIdentifier = rowIdentifier.rawValue
        self.value = value
    }
    
    public func update(row: TableViewRowTextField) {
        row.oldValue = value
    }
}

public struct TableViewRowSwitchUpdate: RowUpdater {
    
    public typealias R = TableViewRowLabelSwitch
    
    public let rowIdentifier: String
    public let value: Bool
    
    public init<T: RawRepresentable>(rowIdentifier: T, value: Bool) where T.RawValue == String {
        self.rowIdentifier = rowIdentifier.rawValue
        self.value = value
    }
    
    public func update(row: TableViewRowLabelSwitch) {
        row.oldValue = value
    }
}

public extension Array where Element: RowUpdater {
    func update(rows: [TableViewRow]) {
        let filteredRows = rows.compactMap { $0 as? Element.R }
        
        for row in filteredRows {
            guard let matchingRow = find(rowIdentifier: row.identifier) else { continue }
            
            matchingRow.update(row: row)
        }
        
        #if DEBUG
        validate(allRows: filteredRows)
        #endif
    }
    
    func find(rowIdentifier: String) -> Element? {
        for row in self {
            guard row.rowIdentifier == rowIdentifier else { continue }
            
            return row
        }
        
        return nil
    }
}

private extension Array where Element: RowUpdater {
    /// Checks if every row in the current update list is present in the allRows parameter.
    /// Ofcourse it is mandatory to, when the user updates a row, it is present in the array of all rows.
    func validate(allRows: [Element.R]) {
        for row in self {
            guard allRows.contains(where: { $0.identifier == row.rowIdentifier }) else { fatalError("Tried to update a row which isn't even in the list.") }
        }
    }
}