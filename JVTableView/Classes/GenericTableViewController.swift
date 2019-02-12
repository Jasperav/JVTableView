import JVNoParameterInitializable
import JVChangeableValue

open class GenericTableViewController<T: JVTableView<U>, U: JVTableViewDatasource>: UITableViewController {
    
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
        #endif
        
        guard tableViewGeneric.headerStretchView != nil else {
            setupRows()
            
            return
        }
        
        tableViewGeneric.correctHeaderImageAfterSetup()
        
        setupRows()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        save()
    }
    
    /// If any rows needs to be configured (one-time), this is the place to do this.
    /// This method gets called after the initializer is done.
    open func setupRows() { }
    
    open func save() {
        #if DEBUG
        assert(tableViewGeneric.jvDatasource.dataSource.flatMap({ $0.rows }).filter({ $0 is Changeable }).count > 0, "There is a changeable row here, but this class doesn't save the changes!")
        #endif
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
