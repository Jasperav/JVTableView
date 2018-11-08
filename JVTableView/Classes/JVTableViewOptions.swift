import JVConstraintEdges
import JVView

public struct JVTableViewOptions {
    public let footer: JVTableViewFooterOptions
    
    public init(footerOptions: JVTableViewFooterOptions) {
        self.footer = footerOptions
    }
}

public struct JVTableViewFooterOptions {
    public let constraintEdges: ConstraintEdges
    public let contentTypeLabel: ContentTypeJVLabel
    
    public init(constraintEdges: ConstraintEdges = ConstraintEdges(leading: 15, trailing: 15, top: 3, bottom: 3), contentTypeLabel: ContentTypeJVLabel) {
        self.constraintEdges = constraintEdges
        self.contentTypeLabel = contentTypeLabel
    }
}
