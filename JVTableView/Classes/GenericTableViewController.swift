import JVNoParameterInitializable
import JVChangeableValue
import JVLoadableImage
import JVDebugProcessorMacros
import JVImagePresenter

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
    public private (set) var headerImageLoadableView: LoadableMedia!
    
    var shouldCallPrepareForSaveWhenViewDidDisappeared: Bool {
        return true
    }
    
    /// This property must be overridden if you are using a header image.
    open var headerImageViewIdentifier: Int64 {
        fatalError()
    }
    
    /// The generic table view.
    public unowned let tableViewGeneric: T
    public let datasourceType = U.self
    
    /// True when the tableView did load the data at least once.
    public private (set) var didReload = false
    
    /// Possibility to override the initalizer.
    /// Be aware we also have a setup() method which omits the required initalizer of the decoder
    public init(tableView: T) {
        tableViewGeneric = tableView
        
        super.init(style: tableView.style)

        self.tableView = tableViewGeneric
        
        for row in tableViewGeneric.rowsWithCustomIdentifier.filter ({ $0.updateUnsafely }) {
            updateUnsafe(datasource: U.self, row: row)
        }

        for row in tableViewGeneric.rows {
            #if DEBUG
            row.validate()
            #endif
        }

        // For all the view controllers that needs to be presented after they have been tapped
        // we do that here.
        for row in tableViewGeneric.rows.filter({ $0.showViewControllerOnTap != nil }) {
            self.present(viewControllerType: row.showViewControllerOnTap!, tapped: &row.tapped)
        }
        
        for row in tableViewGeneric.rows.filter({ $0.isSelectable() && $0._tapped == nil }) {
            row._tapped = { [unowned self] in
                row.tapped!(self)
            }
            
            assert(row._tapped != nil, row.identifier)
            assert(row.tapped != nil, row.identifier)
        }

        #if DEBUG
        tableViewGeneric.validate()
        // If the row is selectable, it must be tappeable.
        for row in tableViewGeneric.rows.filter({ $0.isSelectable() }) {
            assert(row.tapped != nil, row.identifier)
            assert(row._tapped != nil, row.identifier)
        }
        #endif
        
        guard let headerImage = tableViewGeneric.headerImage else { return }
        
        headerImageLoadableView = headerImage.loadableView
        
        headerImageLoadableView!.identifier = headerImageViewIdentifier
        JVTableViewHeaderImageCache.handle(headerImageViewIdentifier, headerImageLoadableView)
        
        headerImageLoadableView!.tapped = { [unowned self] in
            let vc = ImageZoomViewControllerSlide()
            
            JVTableViewHeaderImageCache.handle(self.headerImageLoadableView!.identifier, vc.imageView)
            
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        if headerImageLoadableView != nil {
            tableViewGeneric.correctHeaderImageAfterSetup()
        }
        
        super.viewWillAppear(animated)
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
    
    final func present(viewControllerType: UIViewControllerNoParameterInitializable, tapped: inout ((UIViewController) -> ())?) {
        assert(tapped == nil)
        
        tapped = { [unowned self] _ in
            let viewController = viewControllerType.init()
            
            self.navigationController!.pushViewController(viewController, animated: true)
        }
    }
    
    /// * Recommended overridable methods. *

    open func reloadData(preserveSelectedRow: Bool = false) {
        let selectedIndexPath = tableView.indexPathForSelectedRow
        #if DEBUG
        let changedRows = tableViewGeneric.changeableRows.filter { $0.isChanged }
        #endif
        
        prepareForReload()

        tableViewGeneric.reloadData()
        
        #if DEBUG
        let changedRowsAfterReload = tableViewGeneric.changeableRows.filter { $0.isChanged }
        // If assertion error -> the reload of the tableView caused made changes
        // to disappear
        assert(changedRows.count == changedRowsAfterReload.count)
        
        for (index, row) in changedRows.enumerated() {
            assert(changedRowsAfterReload[index].identifier == row.identifier)
        }
        // Every row should now have a text property
        let tableViewRowsText = tableViewGeneric.jvDatasource.dataSourceVisibleRows.map{ $0.rows }.flatMap { $0 }.compactMap({ $0 as? TableViewRowText })
        
        for row in tableViewRowsText {
            assert(!row.labelSetup.text()!.isEmpty, "A row without text is never good. \(row.identifier)")
        }
        
        let textFields = tableViewGeneric.rows.compactMap { $0 as? TableViewRowTextField }
        
        for text in textFields {
            assert(text.validationBlockUserInput(text.oldValue), "The new data isn't valid at the first place! \(text.identifier)")
        }
        #endif
        
        finishedPreparedForReload()
        
        if let selectedIndexPath = selectedIndexPath, preserveSelectedRow {
            self.tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
        }
    }
    
    /// Prepares to call the save method.
    /// It checks the necessary rows to select and passes it to the save method.
    open func prepareForSave() {
        let changeableRows = tableViewGeneric.changeableRows
        let changedRows = changeableRows.filter { $0.isChanged }
        let rowsThatHaveOwnSaveMethod = changeableRows.filter { $0.save != nil }
        let rowsWithoutOwnSaveMethod = changeableRows.filter { $0.save == nil }
        
        guard changedRows.count > 0 else { return }
        
        for row in changeableRows {
            save(datasource: U.self, changeableRow: row)
        }
        
        for row in rowsWithoutOwnSaveMethod {
            save(datasource: U.self, changedRow: row)
        }
        
        for row in rowsThatHaveOwnSaveMethod {
            row.save!()
        }
        
        savedChangedRows()
    }
    
    /// This method must be overridden if you have rows that have changed.
    /// Will be called if at least one row have been changed.
    open func save(datasource: U.Type, changeableRow: TableViewRow & Changeable) {
        // Don't do anything by default.
    }
    
    /// Called when at least one row has been changed.
    open func savedChangedRows() { }
    
    /// This method must be overridden if you have rows that have changed.
    /// Will be called if at least one row have been changed.
    open func save(datasource: U.Type, changedRow: TableViewRow & Changeable) {
        assert(false, "There are rows to save but this method isn't overridden!")
    }
    
    /// Called before a reload.
    /// Initialize here some values that will be re-used by multiple update statements.
    open func prepareForReload() {}
    
    /// Reset the values that were calculated from prepareForReload()
    open func finishedPreparedForReload() {}
    
    open func updateUnsafe(datasource: U.Type, row: TableViewRow) {
        assert(false)
    }
}
