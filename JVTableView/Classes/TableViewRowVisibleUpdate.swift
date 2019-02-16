public struct TableViewRowVisibleUpdate {
    let rowIdentifier: String
    let isVisible: Bool
    
    public init<T: RawRepresentable>(rowIdentifier: T, isVisible: Bool) where T.RawValue == String {
        self.rowIdentifier = rowIdentifier.rawValue
        self.isVisible = isVisible
    }
}
