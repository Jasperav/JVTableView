import UIKit
import JVView

open class JVLabelCellOptions {
    public let contentTypeJVLabelText: ContentTypeJVLabelText
    public let accessoryType: UITableViewCell.AccessoryType
    
    public init(contentTypeJVLabelText: ContentTypeJVLabelText, accessoryType: UITableViewCell.AccessoryType) {
        self.contentTypeJVLabelText = contentTypeJVLabelText
        self.accessoryType = accessoryType
    }
}
