import JVView

open class TableViewRowLabelImageAndButton: TableViewRowLabelImage {
    
    private let display: Display
    var tappedRightButton: (() -> ())!
    
    public init<T: RawRepresentable>(identifier: T, text: String = "", contentTypeJVLabel: ContentTypeJVLabelText = TableViewRowLabel.standardContentTypeJVLabel, imageLeft: UIImage? = nil, displayRightButton: Display, tapped: (() -> ())? = nil, tappedRightButton: (() -> ())? = nil) {
        self.display = displayRightButton
        self.tappedRightButton = tappedRightButton
        
        super.init(identifier: identifier, text: text, contentTypeJVLabel: contentTypeJVLabel, accessoryType: .none, image: imageLeft, tapped: tapped)
        
        changeClassType(cell: .labelImageAndButton)
    }
    
    open override func configure(cell: TableViewCell) {
        let _cell = cell as! TableViewCellLabelImageAndButton
        
        _cell.button.addTarget(self, action: #selector(_tappedButton), for: .touchUpInside)
        
        switch display {
        case .image(let image):
            _cell.button.setTitle(nil, for: .normal)
            _cell.button.setImage(image, for: .normal)
        case .text(let text):
            _cell.button.setTitle(text, for: .normal)
            _cell.button.setImage(nil, for: .normal)
        }
        
        super.configure(cell: cell)
    }
    
    @objc private func _tappedButton() {
        tappedRightButton()
    }
    
    public enum Display {
        case image(image: UIImage), text(text: String)
    }
}
