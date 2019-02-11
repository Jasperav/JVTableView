import JVNoParameterInitializable
import JVChangeableValue
import JVFormChangeWatcher

open class GenericWatchableTableViewController<T: JVTableView<U>, U: JVTableViewDatasource>: GenericTableViewController<T, U> {
    
    private var formChangeWatcher: FormChangeWatcher<T, GenericWatchableTableViewController<T, U>>!
    
    public override init() {
        super.init()
        
        formChangeWatcher = FormChangeWatcher(changeableForm: tableViewGeneric, viewController: self, update: update)
        
        #if DEBUG
        assert(tableViewGeneric.jvDatasource.dataSource.flatMap({ $0.rows }).filter({ $0 is Changeable }).count > 0, "You are watching a datasource which hasn't got changeable rows")
        #endif
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func update() {
        fatalError()
    }
}
