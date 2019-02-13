public struct TableViewRowTextUpdateListener {
    let rowIdentifier: String
    let text: String
    
    init<T: RawRepresentable>(rowIdentifier: T, text: String) where T.RawValue == String {
        self.rowIdentifier = rowIdentifier.rawValue
        self.text = text
    }
}

public struct TableViewRowTextFieldUpdateListener {
    let rowIdentifier: String
    let text: String
    
    init<T: RawRepresentable>(rowIdentifier: T, text: String) where T.RawValue == String {
        self.rowIdentifier = rowIdentifier.rawValue
        self.text = text
    }
}
