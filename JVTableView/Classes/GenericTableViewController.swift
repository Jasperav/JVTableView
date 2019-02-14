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
        
        setup()
        
        for row in tableViewGeneric.rows.filter({ $0.showViewControllerOnTap != nil }) {
            present(viewControllerType: row.showViewControllerOnTap!, tapped: &row.tapped)
        }
        
        #if DEBUG
        tableViewGeneric.validate()
        #endif
        
        guard tableViewGeneric.headerStretchView != nil else {
            reloadData()
            
            return
        }
        
        tableViewGeneric.correctHeaderImageAfterSetup()
        
        reloadData()
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
        
        let rowsToAddTapHandlersTo = tableViewGeneric.determineRowsWithoutTapHandlers()
        
        addTapHandlers(rows: rowsToAddTapHandlersTo)
        
        assert(tableViewGeneric.determineRowsWithoutTapHandlers().count == 0, "Not every tappable row has a tap listener.")
        
        tableViewGeneric.reloadData()
    }
    
    open func save(allChangeableRows: [TableViewRowUpdate], changedRows: [TableViewRowUpdate]) {
        #if DEBUG
        assert(allChangeableRows.count == 0, "There are rows to save but this method isn't overridden!")
        #endif
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
    
    open func addTapHandlers(rows: [TableViewRow]) {
        assert(rows.count == 0, "There are rows that require to have a tap listener attached to it, but this method isn't overridden.")
    }
    
    open func setup() {
        // One time setup for the view controller.
        // Don't change row values in this method.
    }
}
