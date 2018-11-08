public class TableViewRowLabelImage: TableViewRowLabel {
    public override func isVisible(_ cell: TableViewCellLabel) {
        let _cell = cell as! TableViewCellLabelImage
        
        _cell._imageView.image = (cellOptions as! JVLabelCellOptionsImage).image
    }
}
