import JVLoadableImage

public struct JVTableViewHeaderImage {
    
    /// The image should be set on the loadable view.
    public let loadableView = LoadableMedia(style: .medium, rounded: false, stretched: true)
    
    let height: CGFloat
    
    public init(height: CGFloat) {
        self.height = height
    }
}
