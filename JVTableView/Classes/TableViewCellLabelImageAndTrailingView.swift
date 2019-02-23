import JVUIButtonExtensions
import JVCurrentDevice

open class TableViewCellLabelImageAndButton: TableViewCellLabelImage {
    
    let button = UIButton(type: .system)
    
    open override func setup() {
        super.setup()
        
        button.setContentHuggingAndCompressionResistance(999)
        
        button.stretchImage()
    }
    
    open override func determineTrailingView() -> UIView? {
        return button
    }
}
