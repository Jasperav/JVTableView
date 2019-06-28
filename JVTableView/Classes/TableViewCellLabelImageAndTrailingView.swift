import JVCurrentDevice
import JVUIButton

open class TableViewCellLabelImageAndButton: TableViewCellLabelImage {
    
    open override var trailingView: UIView? {
        return button
    }
    
    let button = UIButton(type: .system)
    
    open override func setup() {
        super.setup()
        button.stretchImage()
    }
}
