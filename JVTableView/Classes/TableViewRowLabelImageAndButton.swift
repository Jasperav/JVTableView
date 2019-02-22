import JVView

open class TableViewRowLabelImageAndButton: TableViewRowLabelImage {
    private let imageForButton: UIImage
    
    var tappedRightButton: (() -> ())!
    
    public init<T: RawRepresentable>(identifier: T, text: String = "", contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel, imageLeft: UIImage? = nil, imageForButton: UIImage, tapped: (() -> ())? = nil, tappedRightButton: (() -> ())? = nil) {
        self.imageForButton = imageForButton
        self.tappedRightButton = tappedRightButton
        
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: .none, image: imageLeft, tapped: tapped)
        
        changeClassType(cell: .labelImageAndButton)
    }
    
    open override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellLabelImageAndButton
        
        _cell.button.addTarget(self, action: #selector(_tappedButton), for: .touchUpInside)
        _cell.button.setImage(imageForButton, for: .normal)
        
        super.configure(cell: cell)
    }
    
    @objc private func _tappedButton() {
        tappedRightButton()
    }
}
