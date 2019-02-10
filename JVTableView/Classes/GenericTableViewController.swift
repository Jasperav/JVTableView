import JVNoParameterInitializable
import JVChangeableValue

open class GenericTableViewController<T: JVTableView<U>, U: JVTableViewDatasource>: UITableViewController where T: NoParameterInitializable {
    
    public unowned let tableViewGeneric: T
    
    public init() {
        // Create a reference else tableViewGeneric gets instantly deinitialized.
        let tableViewGenericReference = T.init()
        
        tableViewGeneric = tableViewGenericReference
        
        super.init(style: tableViewGenericReference.style)
        
        tableView = tableViewGeneric
        
        configure()
        
        for row in tableViewGeneric.jvDatasource.dataSource.flatMap({ $0.rows.filter({ $0.showViewControllerOnTap != nil }) }) {
            present(viewControllerType: row.showViewControllerOnTap!, tapped: &row.tapped)
        }
        
        #if DEBUG
        tableViewGeneric.validate()
        if type(of: self) == GenericTableViewController.self {
            assert(tableViewGenericReference.jvDatasource.dataSource.flatMap({ $0.rows }).allSatisfy({ !($0 is Changeable) }), "There is a changeable row here, but this class doesn't watch the change!")
        }
        #endif
        
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
    
    open func present(viewControllerType: UIViewControllerNoParameterInitializable, tapped: inout (() -> ())?) {
        assert(tapped == nil)
        
        tapped = { [unowned self] in
            let viewController = viewControllerType.init()
            
            self.navigationController!.pushViewController(viewController, animated: true)
        }
    }
}
