public class TableViewSection {
    public let header: String?
    public let footerText: String?
    public var rows: [TableViewRow]
    
    public init(header: String? = nil, footerText: String? = nil, rows: [TableViewRow] = []) {
        self.header = header
        self.footerText = footerText
        self.rows = rows
    }
    
    public convenience init(header: String? = nil, footerText: String? = nil, row: TableViewRow) {
        self.init(header: header, footerText: footerText, rows: [row])
    }
}
