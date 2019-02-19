import JVNoParameterInitializable
import JVChangeableValue
import JVLoadableImage

/// Subclass of UITableViewController.
/// Inhert from this class if you want just want to use a JVTableView without any additional views.
/// It provides a really easy way to display tableviews with really lots of validations
/// Type T: The table view type.
/// Type U: the datasource type.
/// You do not need to create a JVTableView subclass.
open class GenericTableViewController<T: JVTableView<U>, U: JVTableViewDatasource>: UITableViewController {
    
    /// Is filled when the datasource has set the header image.
    /// Implicit unwrapped: it is logically that a subclass that will use this variabele
    /// knows it really has a value. It has no point for a subclass to check whetever
    /// or not this value is filled.
    public private (set) var headerImageLoadableView: LoadableImage!
    
    var shouldCallPrepareForSaveWhenViewDidDisappeared: Bool {
        return true
    }
    
    /// The generic table view.
    unowned let tableViewGeneric: T
    
    /// Possibility to override the initalizer.
    /// Be aware we also have a setup() method which omits the required initalizer of the decoder
    public init() {
        // Create a reference else tableViewGeneric gets instantly deinitialized.
        let tableViewGenericReference = T.init()
        
        tableViewGeneric = tableViewGenericReference
        
        super.init(style: tableViewGenericReference.style)
        
        tableView = tableViewGeneric
        
        // Give the user the possiblity to customize values.
        // See the description of the init() why this method is here.
        setup()
        
        // After the setup, we require every row that is selectable but doesn't have
        // a tapped handler and view controller to present, to add a tap handler.
        let tableViewRowsToAddTapHandlersTo = tableViewGeneric.determineRowsWithoutTapHandlers()
        let rowsToAddTapHandlersTo = tableViewRowsToAddTapHandlersTo.map { TableViewRowTapHandler(row: $0) }
        
        addTapHandlers(rows: rowsToAddTapHandlersTo)
        
        assert(rowsToAddTapHandlersTo.allSatisfy { $0.addedTapHandler }, "Not every tappable row has a tap listener.")
        
        // For all the view controllers that needs to be presented after they have been tapped
        // we do that here.
        for row in tableViewGeneric.rows.filter({ $0.showViewControllerOnTap != nil }) {
            present(viewControllerType: row.showViewControllerOnTap!, tapped: &row.tapped)
        }
        
        #if DEBUG
        tableViewGeneric.validate()
        #endif
        
        guard let headerImage = tableViewGeneric.headerImage else {
            reloadData()
            
            return
        }
        
        headerImageLoadableView = headerImage.loadableView
        
        configure(headerImageView: headerImageLoadableView!)
        
        // The identifier must have changed after configuration.
        assert(headerImageLoadableView!.identifier != 0)
        
        tableViewGeneric.correctHeaderImageAfterSetup()
        
        reloadData()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tableViewGeneric.endEditing(true)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard tableViewGeneric.firstResponderTableViewRowIdentifier != nil else { return }
        makeTextFieldFirstResponder()
    }
    
    /// When the view disappears when want to save the form.
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard shouldCallPrepareForSaveWhenViewDidDisappeared else { return }
        
        prepareForSave()
    }

    public func makeTextFieldFirstResponder() {
        guard let cell = (tableViewGeneric.visibleCells as! [TableViewCell]).first(where: { $0.identifier == tableViewGeneric.firstResponderTableViewRowIdentifier! }) else {
            assert(false, "There is a first responder cell but it isn't visible.")
            
            return
        }
        
        (cell as! TableViewCellTextField).textField.becomeFirstResponder()
    }
    
    /// Prepares to call the save method.
    /// It checks the necessary rows to select and passes it to the save method.
    open func prepareForSave() {
        let changeableRows = tableViewGeneric.retrieveChangeableRows()
        let changedRows = changeableRows.filter { $0.hasChanged }
        
        guard changedRows.count > 0 else { return }
        
        save(changeableRows: changeableRows)
        
        save(changedRows: changedRows)
    }
    
    /// * Recommended overridable methods. *
    
    /// Always call super.reloadData() if you override this method.
    open func reloadData() {
        let textUpdates = createTableViewRowTextUpdates()
        let textFieldUpdates = createTableViewRowTextFieldUpdates()
        let switchUpdates = createTableViewRowSwitchUpdates()
        
        #if DEBUG
        // Checks if there are no duplicate identifiers.
        let rowIdentifiers = Set(textUpdates.map { $0.rowIdentifier } + textFieldUpdates.map { $0.rowIdentifier } + switchUpdates.map { $0.rowIdentifier })
        
        assert(rowIdentifiers.count == textUpdates.count + textFieldUpdates.count + switchUpdates.count, "Duplicate identifer for update")
        
        // Every row that has a switch must be updated at runtime.
        // This means that the count of switchUpdates must be equal to the total amount of switch rows in the datasource.
        let switchableRows = tableViewGeneric.rows.compactMap { $0 as? TableViewRowLabelSwitch }
        
        assert(switchableRows.count == switchUpdates.count)
        #endif
        
        textUpdates.update(rows: tableViewGeneric.rowsWithCustomIdentifier)
        textFieldUpdates.update(rows: tableViewGeneric.rowsWithCustomIdentifier)
        switchUpdates.update(rows: tableViewGeneric.rowsWithCustomIdentifier)
        
        #if DEBUG
        // Every row should now have a text property
        let texts = tableViewGeneric.rows
            .compactMap({ $0 as? TableViewRowText })
            .map({ $0._text })
        
        for text in texts {
            assert(text != "", "A row without text is never good.")
        }
        
        let textFields = tableViewGeneric.rows.compactMap({ $0 as? TableViewRowTextField })
        
        for text in textFields {
            assert(text.validationBlockUserInput(text.oldValue), "The new data isn't valid at the first place!")
        }
        #endif
        
        let visibleUpdateRows = createTableViewRowConditionallyVisible()
        
        assert(Set(visibleUpdateRows).count == visibleUpdateRows.count, "The row identifier is used twice, this is illegal")
        
        for row in visibleUpdateRows {
            let tableViewRow = tableViewGeneric.jvDatasource.getRow(row.rowIdentifier)
            
            tableViewRow.showInTableView = { return row.isVisible }
        }
        
        tableViewGeneric.reloadData()
    }
    
    /// This method must be overridden if you have rows that have changed.
    /// Will be called if at least one row have been changed.
    open func save(changeableRows: [TableViewRowUpdate]) {
        assert(changeableRows.count == 0, "There are rows to save but this method isn't overridden!")
    }
    
    /// This method must be overridden if you have rows that have changed.
    /// Will be called if at least one row have been changed.
    open func save(changedRows: [TableViewRowUpdate]) {
        assert(changedRows.count == 0, "There are rows to save but this method isn't overridden!")
    }
    
    /// Returns the rows that needs to have there value properties dynamically updated
    open func createTableViewRowTextUpdates() -> [TableViewRowTextUpdate] {
        // By default we dont have any listeners
        return []
    }
    
    /// Returns the rows that needs to have there value properties dynamically updated
    open func createTableViewRowTextFieldUpdates() -> [TableViewRowTextFieldUpdate] {
        // By default we dont have any listeners
        return []
    }
    
    /// Returns the rows that needs to have there value properties dynamically updated
    open func createTableViewRowSwitchUpdates() -> [TableViewRowSwitchUpdate] {
        // By default we dont have any listeners
        return []
    }
    
    /// Creates the rows that needs to be dynamically visible
    open func createTableViewRowConditionallyVisible() -> [TableViewRowVisibleUpdate] {
        return []
    }
    
    /// This method must be overridden if you are using a header image.
    open func configure(headerImageView: LoadableImage) {
        fatalError()
    }
    
    /// Some view controllers do not conform to NoParameterInitializable
    /// Because they need more info when they are initialized.
    /// Do that here.
    open func addTapHandlers(rows: [TableViewRowTapHandler]) {
        assert(rows.count == 0, "There are rows that require to have a tap listener attached to it, but this method isn't overridden.")
    }
    
    /// One time setup for the view controller.
    /// See the description of the init() why this method is here.
    open func setup() {}
    
    open func present(viewControllerType: UIViewControllerNoParameterInitializable, tapped: inout (() -> ())?) {
        assert(tapped == nil)
        
        tapped = { [unowned self] in
            let viewController = viewControllerType.init()
            
            self.navigationController!.pushViewController(viewController, animated: true)
        }
    }
}
