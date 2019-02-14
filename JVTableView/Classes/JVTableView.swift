import UIKit
import JVConstraintEdges
import JVTappable
import JVView
import JVFormChangeWatcher
import JVLoadableImage
import JVChangeableValue
import JVNoParameterInitializable

open class JVTableView<U: JVTableViewDatasource>: UITableView, ChangeableForm, UITableViewDataSource, UITableViewDelegate, NoParameterInitializable {
    
    public private (set) var headerStretchImage: JVTableViewHeaderStretchImage?
    public private (set) var headerStretchView: LoadableImage?
    
    public var formHasChanged: ((_ hasNewValues: Bool) -> ())?
    
    public let jvDatasource: U
    
    let rowsWithCustomIdentifier: [TableViewRow]
    
    private let changeableRows: [TableViewRow & Changeable]
    
    public required init() {
        let tempJVDatasource = U.init()
        
        let rows = tempJVDatasource.dataSource.flatMap({ $0.rows })
        
        rowsWithCustomIdentifier = rows.filter({ $0.identifier != TableViewRow.defaultRowIdentifier })
        
        changeableRows = rows.compactMap { $0 as? TableViewRow & Changeable }
        
        jvDatasource = tempJVDatasource
        
        super.init(frame: CGRect.zero, style: jvDatasource.determineStyle())
        
        self.headerStretchImage = jvDatasource.determineHeaderStretchImage()

        var insertedClassTypes: Set<String> = []
        
        for row in rows {
            let classIdentifier = row.classIdentifier
            
            guard insertedClassTypes.insert(classIdentifier).inserted else { break }
            
            register(row.classType, forCellReuseIdentifier: classIdentifier)
        }
        
        sectionFooterHeight = UITableView.automaticDimension
        estimatedSectionFooterHeight = 5
        
        dataSource = self
        delegate = self
        
        tableFooterView = UIView()
        
        #if DEBUG
        validate()
        #endif
        
        reloadData()
        
        guard let headerStretchImage = headerStretchImage else { return }
        
        add(headerStretchImage: headerStretchImage)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    public func validate() {
        #if DEBUG
        // Either the tapped closure must be filled in, or it has a custom identifier.
        // see tapped(identifier: String) for more information.
        for row in jvDatasource.dataSource.flatMap({ $0.rows.filter({ $0.isSelectable }) }) {
            assert(row.tapped != nil || row.identifier != TableViewRow.defaultRowIdentifier)
        }
        
        // If the row isn't selectable, it can not be tappable.
        for row in jvDatasource.dataSource.flatMap({ $0.rows.filter({ !$0.isSelectable }) }) {
            assert(row.tapped == nil)
        }
        
        // Omit duplicated
        let rowsCustomIdentifier = jvDatasource.dataSource.flatMap({ $0.rows.filter({ $0.identifier != TableViewRow.defaultRowIdentifier}) }).map({ $0.identifier })
        var customIdentifiers = Set<String>()
        
        for identifier in rowsCustomIdentifier {
            assert(customIdentifiers.insert(identifier).inserted)
        }
        
        for row in changeableRows {
            // Every changeable row should have an identifier
            assert(row.identifier != TableViewRow.defaultRowIdentifier)
            // Every changeable row must override determineCurrentValue().
            // The default method throws a fatalerror. We check if it doesn't throw.
            row.determineUpdateType()
        }
        #endif
    }
    
    open override func reloadData() {
        jvDatasource.determineSectionsWithVisibleRows()
        
        super.reloadData()
    }
    
    /// Call this once after you did setup the whole tableview & datasource.
    /// AND you have a header image view.
    /// If there is an header image, this view needs to be explicitly layout out.
    /// If this doesn't happen, the headerimage is shown half.
    /// I don't know the technical reason of why this is needed...
    public func correctHeaderImageAfterSetup() {
        layoutIfNeeded()
    }
    
    private func add(headerStretchImage: JVTableViewHeaderStretchImage) {
        headerStretchView = LoadableImage(style: .gray, rounded: false)
        
        headerStretchView!.stretchImage()
        
        contentInset = UIEdgeInsets(top: headerStretchImage.height, left: 0, bottom: 0, right: 0)
        
        addSubview(headerStretchView!)
        
        guard let image = headerStretchImage.image else { return }
        
        headerStretchView!.show(image: image)
    }
    
    private func updateHeaderStretchImageView() {
        guard let headerStretchImage = headerStretchImage else { return }
        
        var headerRect = CGRect(x: 0, y: -headerStretchImage.height, width: bounds.width, height: headerStretchImage.height)
        
        if contentOffset.y < -headerStretchImage.height {
            headerRect.origin.y = contentOffset.y
            headerRect.size.height = -contentOffset.y
        }
        
        headerStretchView!.frame = headerRect
    }
    
    private func checkIfFormChanged() {
        guard let formHasChanged = formHasChanged else { return }
        
        for section in jvDatasource.dataSource {
            for row in section.rows {
                guard let changeableRow = row as? Changeable, changeableRow.determineHasBeenChanged() else { continue }
                formHasChanged(true)
                
                return
            }
        }
        
        formHasChanged(false)
    }
    
    /// Resets everything to the oldValues
    /// Set reloadData to true after a whole update. This is false by default because:
    /// when a user is typing something a textField and that textField has at a moment the same oldValue and newValue,
    /// The keyboard disappears.
    public func resetForm(reloadData: Bool = false) {
        for section in jvDatasource.dataSource {
            for row in section.rows {
                guard let changeableRow = row as? Changeable else { continue }
                changeableRow.reset()
            }
        }
        
        if reloadData {
            self.reloadData()
        }
    }
    
    public func resetForm() {
        resetForm(reloadData: true)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return jvDatasource.dataSourceVisibleRows.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jvDatasource.dataSourceVisibleRows[section].rows.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = jvDatasource.getRow(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: row.classIdentifier, for: indexPath)
        
        row.configure(cell: cell as! TableViewCell)
        
        if let changeableRow = row as? Changeable {
            changeableRow.hasChanged = { [weak self] (_) in
                self?.checkIfFormChanged()
            }
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return jvDatasource.getSection(section).header
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return jvDatasource.getSection(section).footerText
    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = jvDatasource.getRow(indexPath)
        
        return cell.isSelectable ? indexPath : nil
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = jvDatasource.getRow(indexPath)
        
        if let tapped = row.tapped {
            tapped()
        } else {
            assert(row.identifier != TableViewRow.defaultRowIdentifier)
            
            tapped(identifier: row.identifier)
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderStretchImageView()
    }
    
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        view.endEditing(true)
    //    }
    
    /// For allowing easier tapping, this method is available.
    /// Without this method, we would have a lot of methods with getRow...() in the initalizer of the implementing class.
    /// This omits that all.
    open func tapped(identifier: String) {
        fatalError()
    }
    
    open func retrieveChangeableRows() -> [TableViewRowUpdate] {
        return changeableRows.map { TableViewRowUpdate(changeableRow: $0) }
    }
}
