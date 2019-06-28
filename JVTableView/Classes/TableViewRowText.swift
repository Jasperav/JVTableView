import JVView
import JVConstraintEdges
import JVNoParameterInitializable
import JVChangeableValue

open class TableViewRowText: TableViewRow {
    
    public var labelSetup = TextSetup(font: UIFont.TextStyle.body)
    
    public init<T: RawRepresentable>(identifier: T, text: @escaping (() -> (String))) {
        super.init(identifier: identifier)
        
        labelSetup.text = text
    }
    
    public init(text: @escaping (() -> (String)))  {
        super.init()
        
        labelSetup.text = text
    }
    
    public init<T: RawRepresentable>(identifier: T, text: String) {
        super.init(identifier: identifier)
        
        labelSetup.text =  { return text }
    }
    
    public init(rawIdentifier: String = TableViewRow.defaultRowIdentifier, text: String) {
        super.init(rawIdentifier: rawIdentifier)
        
        labelSetup.text = { return text }
    }
}
