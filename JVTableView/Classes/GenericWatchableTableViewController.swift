import JVNoParameterInitializable
import JVChangeableValue
import JVFormChangeWatcher

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
    
    public override init() {
        super.init()
        
        formChangeWatcher = FormChangeWatcher(changeableForm: tableViewGeneric, viewController: self, topRightButtonText: topRightButtonText, topLeftButtonTextWhenFormIsChanged: topLeftButtonText, tappedTopRightButton: tappedTopRightButton)
        
        assert(tableViewGeneric.changeableRows.count > 0, "You are watching a datasource which hasn't got changeable rows")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if DEBUG
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard topLeftButtonText != nil else { return }
        
        assert(tableViewGeneric.changeableRows.allSatisfy({ !$0.isChanged }), "UIViewController is invisible, but there are rows changed")
    }
    #endif
    
    private func tappedTopRightButton() {
        view.endEditing(true)
        
        prepareForSave()
    }

}
