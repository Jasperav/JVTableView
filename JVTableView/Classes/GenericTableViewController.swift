import JVNoParameterInitializable

open class GenericTableViewController<T: JVTableView>: UITableViewController where T: NoParameterInitializable {
    
    public unowned let tableViewGeneric: T
    
    public init() {
        // Create a reference else tableViewGeneric gets instantly deinitialized.
        let tableViewGenericReference = T.init()
        
        tableViewGeneric = tableViewGenericReference
        
        super.init(style: tableViewGenericReference.style)
        
        tableView = tableViewGeneric
        
        configure()
        
        guard tableViewGeneric.headerStretchView != nil else { return }
        
        tableViewGeneric.correctHeaderImageAfterSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Called right after the init completely setted up.
    open func configure() {
        // Nothing by default
    }
}
