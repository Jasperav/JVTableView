import JVCurrentDevice
import JVUIButtonExtensions

open class TableViewCellLabelImageAndButton: TableViewCellLabelImage {
    
    open override var trailingView: UIView? {
        return button
    }
    
    let button = UIButton(type: .system)
    
    open override func setup() {
        super.setup()
        // TODO: Link JVUIButton
        button.stretchImage()
    }
}
