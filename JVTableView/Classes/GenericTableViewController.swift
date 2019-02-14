import JVNoParameterInitializable
import JVChangeableValue

open class GenericTableViewController<T: JVTableView<U>, U: JVTableViewDatasource>: UITableViewController {
    
    unowned let tableViewGeneric: T
    
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
    
    open func present(viewControllerType: UIViewControllerNoParameterInitializable, tapped: inout (() -> ())?) {
        assert(tapped == nil)
        
        tapped = { [unowned self] in
            let viewController = viewControllerType.init()
            
            self.navigationController!.pushViewController(viewController, animated: true)
        }
    }
    
    
    
    /// * Recommended overridable methods. *
    
    /// Always call super.reloadData() if you override this method.
    open func reloadData() {
        let textUpdates = createTableViewRowTextUpdates()
        let textFieldUpdates = createTableViewRowTextFieldUpdates()
        let switchUpdates = createTableViewRowSwitchUpdates()
        
        #if DEBUG
        let rowIdentifiers = Set(textUpdates.map { $0.rowIdentifier } + textFieldUpdates.map { $0.rowIdentifier } + switchUpdates.map { $0.rowIdentifier })
        
        assert(rowIdentifiers.count == textUpdates.count + textFieldUpdates.count + switchUpdates.count, "Duplicate identifer for update")
        #endif
        
        textUpdates.update(rows: tableViewGeneric.rowsWithCustomIdentifier)
        textFieldUpdates.update(rows: tableViewGeneric.rowsWithCustomIdentifier)
        switchUpdates.update(rows: tableViewGeneric.rowsWithCustomIdentifier)
        
        #if DEBUG
        // Every row should now have a text property
        let texts = tableViewGeneric.jvDatasource.dataSource
            .flatMap({ $0.rows })
            .compactMap({ $0 as? TableViewRowText })
            .map({ $0._text })
        
        for text in texts {
            assert(text != "")
        }
        
        let textFields = tableViewGeneric.jvDatasource.dataSource
            .flatMap({ $0.rows })
            .compactMap({ $0 as? TableViewRowTextField })
            .map({ $0.oldValue })
        
        for text in textFields {
            assert(text != "")
        }
        #endif
        
        tableViewGeneric.reloadData()
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
        reloadData()
    }
    
    open func createTableViewRowTextUpdates() -> [TableViewRowTextUpdate] {
        // By default we dont have any listeners
        return []
    }
    
    open func createTableViewRowTextFieldUpdates() -> [TableViewRowTextFieldUpdate] {
        // By default we dont have any listeners
        return []
    }
    
    open func createTableViewRowSwitchUpdates() -> [TableViewRowSwitchUpdate] {
        return []
    }
}
