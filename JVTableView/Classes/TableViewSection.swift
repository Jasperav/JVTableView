public class TableViewSection {
    public let header: String?
    public let footerText: String?
    public var rows: [TableViewRow]
    
    public init(header: String? = nil, footerText: String? = nil, rows: [TableViewRow] = []) {
        self.header = header
        self.footerText = footerText
        self.rows = rows
    }
}
