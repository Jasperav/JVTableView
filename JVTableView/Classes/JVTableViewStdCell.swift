import UIKit
import JVView
import JVContentType

public enum JVTableViewStdCell: String, CaseIterable {
    case
    textField,
    label,
    labelSwitch,
    labelImage,
    labelDetail,
    button,
    labelImageAndButton
    
    var classType: TableViewCell.Type {
        switch self {
        case .textField:
            return TableViewCellTextField.self
        case .label:
            return TableViewCellLabel.self
        case .labelSwitch:
            return TableViewCellLabelSwitch.self
        case .labelImage:
            return TableViewCellLabelImage.self
        case .labelDetail:
            return TableViewCellLabelWithDetail.self
        case .button:
            return TableViewCellButton.self
        case .labelImageAndButton:
            return TableViewCellLabelImageAndButton.self
        }
    }
}
