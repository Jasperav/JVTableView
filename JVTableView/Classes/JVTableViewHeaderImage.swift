import JVLoadableImage

public struct JVTableViewHeaderImage {
    /// The image should be set on the loadable view.
    public let loadableView = LoadableImage(style: .gray, rounded: false)
    
    let height: CGFloat
    
    public init(height: CGFloat) {
        self.height = height
    }
}
