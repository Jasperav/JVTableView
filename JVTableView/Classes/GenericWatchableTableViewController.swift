import JVNoParameterInitializable
import JVChangeableValue
import JVFormChangeWatcher
import JVDebugProcessorMacros

/// This class is the same as a standard tableview but it will display (depending on the
/// state) a topleft and topright button.
open class GenericWatchableTableViewController<T: JVTableView<U>, U: JVTableViewDatasource>: GenericTableViewController<T, U> {
    
    override var shouldCallPrepareForSaveWhenViewDidDisappeared: Bool {
        return false
    }
    
    open var topRightButtonText: String {
        return FormChangeWatcherDefaultValues.defaultTopRightButtonText
    }
    
    /// When nil, the form change watcher topRightButtonState == .disabledWhenFormIsInvalid
    /// Else, .hiddenWhenFormIsNotChanged
    open var topLeftButtonText: String? {
        return FormChangeWatcherDefaultValues.defaultTopLeftButtonText
    }
    
    private var formChangeWatcher: FormChangeWatcher<T, GenericWatchableTableViewController<T, U>>!
    
    public override init(tableView: T) {
        super.init(tableView: tableView)
        
        setupNavigationItemButtons()
        
        formChangeWatcher = FormChangeWatcher(changeableForm: tableViewGeneric, viewController: self, topRightButtonText: topRightButtonText, topLeftButtonTextWhenFormIsChanged: topLeftButtonText, tappedTopRightButton: tappedTopRightButton)
        
        assert(tableViewGeneric.changeableRows.count > 0, "You are watching a datasource which hasn't got changeable rows")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    open func setupNavigationItemButtons() {
        // Perfect place for adding the navigation items.
        // After this method is called, formChangeWatcher will be initialized.
    }
    
    /// Call this method when you successfully processed the saving method
    /// and the changeablerows should change there oldValue by currentValue.
    public final func savedChangeableRows() {
        DispatchQueue.main.async {
            for row in self.tableViewGeneric.changeableRows {
                row.updateFromCurrentState()
            }
            
            assert(self.tableViewGeneric.changeableRows.filter { $0.isChanged }.count == 0)
            self.formChangeWatcher.handleFormChange(hasNewValues: false)
        }
    }
    
    private func tappedTopRightButton() {
        view.endEditing(true)
        
        prepareForSave()
    }
    
    #if DEBUG
    deinit {
        guard topLeftButtonText != nil else { return }
        
        assert(tableViewGeneric.changeableRows.allSatisfy({ !$0.isChanged }), "UIViewController is deinit, but there where rows changed")
    }
    #endif
}
