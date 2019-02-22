import JVUIButtonExtensions

open class TableViewCellLabelImageAndButton: TableViewCellLabelImage {
    
    let button = UIButton(type: .system)
    
    open override func setup() {
        super.setup()
        
        button.stretchImage()
        button.setContentCompressionResistance(999)
        
        addButtonWidth()
    }
    
    open override func determineTrailingView() -> UIView? {
        return button
    }
    
    open func addButtonWidth() {
        fatalError()
    }
}
