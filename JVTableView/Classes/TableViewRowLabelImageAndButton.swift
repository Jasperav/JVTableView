import JVView

open class TableViewRowLabelImageAndButton: TableViewRowLabelImage {
    
    open override var classType: TableViewCell.Type {
        return TableViewCellLabelImageAndButton.self
    }
    
    public var tappedRightButton: ((TableViewCellLabelImageAndButton) -> ())!
    
    private let textRightButton: (() -> (String))
    private weak var cell: TableViewCellLabelImageAndButton?
    
    public init<T: RawRepresentable>(identifier: T, text: String, image: @escaping (() -> (Image)), textRightButton: @escaping (() -> (String))) {
        self.textRightButton = textRightButton
        
        super.init(identifier: identifier, text: text, image: image)
    }
    
    public init(text: @escaping (() -> (String)), image: @escaping (() -> (Image)), textRightButton: @escaping (() -> (String))) {
        self.textRightButton = textRightButton
        
        super.init(text: text, image: image)
    }

    open override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellLabelImageAndButton
        
        self.cell = _cell
        
        _cell.button.addTarget(self, action: #selector(tappedViewControllerButton), for: .touchUpInside)
        _cell.button.setTitle(textRightButton(), for: .normal)
        
        super.configure(cell: cell)
    }
    
    open override func commonLoad() {
        isSelectable = {
            return false
        }
        
        accessoryType = .none
        
        super.commonLoad()
    }
    
    @objc private func tappedViewControllerButton() {
        tappedRightButton(cell!)
    }
    
    #if DEBUG
    open override func validate() {
        super.validate()
        
        assert(tappedRightButton != nil)
    }
    #endif
}
