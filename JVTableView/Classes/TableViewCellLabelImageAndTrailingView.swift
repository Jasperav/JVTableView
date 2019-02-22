import JVUIButtonExtensions
import JVCurrentDevice

open class TableViewCellLabelImageAndButton: TableViewCellLabelImage {
    
    let button = UIButton(type: .system)
    
    open override func setup() {
        super.setup()
        
        button.setContentCompressionResistance(999)
        
        button.stretchImage()
    }
    
    open override func determineTrailingView() -> UIView? {
        return button
    }
}
