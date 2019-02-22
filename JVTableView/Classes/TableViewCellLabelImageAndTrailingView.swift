import JVUIButtonExtensions
import JVCurrentDevice

open class TableViewCellLabelImageAndButton: TableViewCellLabelImage {
    
    let button = UIButton(type: .system)
    
    open override func setup() {
        super.setup()
        
        button.setContentCompressionResistance(999)
        button.setWidth(determineButtonWidth())
        
        button.stretchImage()
    }
    
    open override func determineTrailingView() -> UIView? {
        return button
    }
    
    open func determineButtonWidth() -> CGFloat {
        return CurrentDevice.getValue(tablet: 40, phone: 30)
    }
}
