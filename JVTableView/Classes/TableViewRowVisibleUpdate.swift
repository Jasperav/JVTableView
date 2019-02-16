public struct TableViewRowVisibleUpdate: Hashable {
    let rowIdentifier: String
    let isVisible: Bool
    
    public init<T: RawRepresentable>(rowIdentifier: T, isVisible: Bool) where T.RawValue == String {
        self.rowIdentifier = rowIdentifier.rawValue
        self.isVisible = isVisible
    }
    
    public static func == (lhs: TableViewRowVisibleUpdate, rhs: TableViewRowVisibleUpdate) -> Bool {
        return lhs.rowIdentifier == rhs.rowIdentifier
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rowIdentifier)
    }
}
