public protocol SectionCreator {}

public protocol SectionIdentifier {}

public protocol RowCreator {}

public protocol RowIdentifier {}

public protocol RowConfigurer {}

public func getRow() -> TableViewRowButton {
    return TableViewRowButton(text: "test", url: "test")
}
