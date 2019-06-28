import JVView
import JVNoParameterInitializable
import JVURLOpener

open class TableViewRowButton: TableViewRowText {
    
    open override var classType: TableViewCell.Type {
        return TableViewCellButton.self
    }

    public init(text: String, urlToOpenWhenTapped: String) {
        super.init(text: text)
        
        tapped = { _ in
            URLOpener.open(url: urlToOpenWhenTapped)
        }
    }
    
    override open func commonLoad() {
        isSelectable = { return true }
        
        super.commonLoad()
    }
    
    open override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellButton
        
        _cell.button.setTitle(labelSetup.text(), for: .normal)
        
        super.configure(cell: cell)
    }
    
    open override func makeSelectable(cell: TableViewCell) {
        let _cell = cell as! TableViewCellButton
        
        _cell.button.isEnabled = true
    }
    
    open override func makeUnselectable(cell: TableViewCell) {
        let _cell = cell as! TableViewCellButton
        
        _cell.button.isEnabled = false
    }
}
