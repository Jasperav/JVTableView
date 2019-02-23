import JVView

open class TableViewRowLabelImageAndButton: TableViewRowLabelImage {
    
    var tappedRightButton: ((TableViewCellLabelImageAndButton) -> ())!
    
    private let textRightButton: String
    private weak var cell: TableViewCellLabelImageAndButton?
    
    public init<T: RawRepresentable>(identifier: T, text: String = "", contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel, imageLeft: UIImage? = nil, textRightButton: String, tappedRightButton: ((TableViewCellLabelImageAndButton) -> ())? = nil) {
        self.textRightButton = textRightButton
        self.tappedRightButton = tappedRightButton
        
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: .none, image: imageLeft, tapped: nil)
        
        changeClassType(cell: .labelImageAndButton)
    }
    
    open override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellLabelImageAndButton
        
        self.cell = _cell
        
        _cell.button.addTarget(self, action: #selector(_tappedButton), for: .touchUpInside)
        
        _cell.button.setTitle(textRightButton, for: .normal)
        
        super.configure(cell: cell)
    }
    
    @objc private func _tappedButton() {
        tappedRightButton(cell!)
    }
}
