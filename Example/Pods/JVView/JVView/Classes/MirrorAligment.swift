import UIKit
import JVCurrentDevice

// This isnt needed I think if the aligment is set to natural
public extension UILabel {
    
    public func mirrorAligmentIfRightToLeftLanguage() {
        if CurrentDevice.isRightToLeftLanguage {
            if textAlignment == .left {
                textAlignment = .right
            } else if textAlignment == .right {
                textAlignment = .left
            }
        }
    }
    
}
