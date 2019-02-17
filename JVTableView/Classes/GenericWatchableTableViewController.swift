import JVNoParameterInitializable
import JVChangeableValue
import JVFormChangeWatcher

/// This class is the same as a standard tableview but it will display (depending on the
/// state) a topleft and topright button.
open class GenericWatchableTableViewController<T: JVTableView<U>, U: JVTableViewDatasource>: GenericTableViewController<T, U> {
    
    override var shouldCallPrepareForSaveWhenViewDidDisappeared: Bool {
        return false
    }
    
    private var formChangeWatcher: FormChangeWatcher<T, GenericWatchableTableViewController<T, U>>!
    
    public init(topRightButtonText: String = FormChangeWatcherDefaultValues.defaultTopRightButtonText, topLeftButtonTextWhenFormIsChanged: String? = FormChangeWatcherDefaultValues.defaultTopLeftButtonText) {
        super.init()
        
        formChangeWatcher = FormChangeWatcher(changeableForm: tableViewGeneric, viewController: self, topRightButtonText: determineTopRightButtonText(), topLeftButtonTextWhenFormIsChanged: determineHasCancelButtonAsTopLeftButton() ? FormChangeWatcherDefaultValues.defaultTopLeftButtonText : nil, tappedTopRightButton: prepareForSave)
        
        #if DEBUG
        assert(tableViewGeneric.changeableRows.count > 0, "You are watching a datasource which hasn't got changeable rows")
        #endif
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func determineHasCancelButtonAsTopLeftButton() -> Bool {
        return true
    }
    
    open func determineTopRightButtonText() -> String {
        return FormChangeWatcherDefaultValues.defaultTopRightButtonText
    }

}
