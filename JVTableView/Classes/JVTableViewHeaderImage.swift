import JVLoadableImage

public struct JVTableViewHeaderImage {
    
    public static var defaultHeight: CGFloat = -1
    
    /// The image should be set on the loadable view.
    public let loadableView = LoadableImage(style: .gray, rounded: false)
    
    let height: CGFloat
    
    public init(height: CGFloat = JVTableViewHeaderImage.defaultHeight) {
        self.height = height
    }
}
