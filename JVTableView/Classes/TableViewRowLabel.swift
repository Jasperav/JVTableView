import JVView
import JVNoParameterInitializable

open class TableViewRowLabel: TableViewRowText {
    
    open override var classType: TableViewCell.Type {
        return TableViewCellLabel.self
    }

    open override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellLabel
        
        _cell.label.update(setup: labelSetup)
        
        super.configure(cell: cell)
    }
    
    open override func makeUnselectable(cell: TableViewCell) {
        let _cell = cell as! TableViewCellLabel
        
        _cell.label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    @discardableResult
    public func makeDestructive() -> Self {
        labelSetup.color = .systemRed
        
        return self
    }
}
