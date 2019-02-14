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
        
        prepareForSave()
    }
    
    public func prepareForSave() {
        let changeableRows = tableViewGeneric.retrieveChangeableRows()
        let changedRows = changeableRows.filter { $0.hasChanged }
        
        save(allChangeableRows: changeableRows, changedRows: changedRows)
    }
    
    /// If any rows needs to be configured (one-time), this is the place to do this.
    /// This method gets called after the initializer is done.
    open func setupRows() { }
    
    open func save(allChangeableRows: [TableViewRowUpdate], changedRows: [TableViewRowUpdate]) {
        #if DEBUG
        assert(allChangeableRows.count == 0, "There are rows to save but this method isn't overridden!")
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
