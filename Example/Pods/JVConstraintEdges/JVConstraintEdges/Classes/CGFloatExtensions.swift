import UIKit

public extension CGFloat {
    public func inversed() -> CGFloat {
        return -self
    }
    
    public mutating func inverse() {
        self = -self
    }
    
    public func increased(_ by: CGFloat) -> CGFloat {
        return self + by
    }
    
    public mutating func increase(_ by: CGFloat) {
        self += by
    }
    
    public func decreased(_ by: CGFloat) -> CGFloat {
        return self - by
    }
    
    public mutating func decrease(_ by: CGFloat) {
        self -= by
    }
}

