import JVCurrentDevice

public struct JVTableViewHeaderStretchImage {
    
    public static var defaultHeight: CGFloat = CurrentDevice.getValue(tablet: 300, phone: 300)
    
    public let height: CGFloat
    public let image: UIImage?
    
    public init(height: CGFloat = JVTableViewHeaderStretchImage.defaultHeight, image: UIImage?) {
        self.height = height
        self.image = image
    }
}
