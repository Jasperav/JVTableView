import JVChangeableValue

public enum TableViewRowUpdateType {
    case text(String), bool(Bool), other(Any)
    
    var asText: String {
        switch self {
        case .text(let text):
            return text
        default:
            fatalError()
        }
    }
    
    var asBool: Bool {
        switch self {
        case .bool(let bool):
            return bool
        default:
            fatalError()
        }
    }
}

public struct TableViewRowUpdate {
    public let identifier: String
    public let hasChanged: Bool
    public let value: TableViewRowUpdateType
    
    init(changeableRow: Changeable & TableViewRow) {
        identifier = changeableRow.identifier
        hasChanged = changeableRow.determineHasBeenChanged()
        value = changeableRow.determineUpdateType()
    }
}
