import UIKit
import JVConstraintEdges
import JVTappable
import JVView
import JVFormChangeWatcher
import JVLoadableImage
import JVChangeableValue
import JVNoParameterInitializable
import JVInputValidator

open class JVTableView<U: JVTableViewDatasource>: UITableView, ChangeableForm, UITableViewDataSource, UITableViewDelegate, NoParameterInitializable {
    
    /// Will be called when anything in the form has been changed.
    /// Not mandatory when you have a screen which won't update directly
    /// When the screen disappears, the save method will be called
    /// With an array of changed rows.
    /// This property is usefull when you want to be directly notified if anything in the form has changed.
    public var formHasChanged: ((_ hasNewValues: Bool) -> ())?
    
    /// The header stretch view which will maintain the stretch image.
    public private (set) var headerImage: JVTableViewHeaderImage?
    
    /// Making the datasource non-public will prevent the developer to directly modify rows.
    /// This is always illegal and can cause a corrupted state.
    let jvDatasource: U
    
    /// Contains all the rows of jvDatasource.
    let rows: [TableViewRow]
    
    /// Contains all the rows of jvDatasource which rowIdentifier isn't set to the default ("").
    let rowsWithCustomIdentifier: [TableViewRow]
    
    /// Contains all the rows of jvDatasource which conforms to the protocol Changeable.
    let changeableRows: [TableViewRow & Changeable]
    
    let firstResponderTableViewRowIdentifier: String?
    
    /// Contains all the rows of jvDatasource which conforms to the protocol InputValidateable.
    private let rowInputValidators: [InputValidator]
    
    public required init() {
        let tempJVDatasource = U.init()
        
        rows = tempJVDatasource.dataSource.flatMap({ $0.rows })
        
        rowsWithCustomIdentifier = rows.filter({ $0.identifier != TableViewRow.defaultRowIdentifier })
        
        changeableRows = rows.compactMap { $0 as? TableViewRow & Changeable }
        
        rowInputValidators = rows.compactMap { $0 as? InputValidateable }.map { $0.inputValidator }
        
        firstResponderTableViewRowIdentifier = rowsWithCustomIdentifier.compactMap { $0 as? TableViewRowTextField }.first(where: { $0.isFirstResponder })?.identifier
        
        jvDatasource = tempJVDatasource
        
        super.init(frame: CGRect.zero, style: jvDatasource.determineStyle())
        
        headerImage = jvDatasource.determineHeaderImage()
        
        registerUniqueCellTypes()
        
        sectionFooterHeight = UITableView.automaticDimension
        estimatedSectionFooterHeight = 5
        
        dataSource = self
        delegate = self
        
        tableFooterView = UIView()
        
        #if DEBUG
        validate()
        #endif
        
        reloadData()
        
        guard let headerImage = headerImage else { return }
        
        setup(headerImage: headerImage)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    public func validate() {
        #if DEBUG
        
        // If the row isn't selectable, it can not be tappable or showViewControllerOnTap.
        for row in jvDatasource.dataSource.flatMap({ $0.rows.filter({ !$0.isSelectable }) }) {
            assert(row.tapped == nil && row.showViewControllerOnTap == nil)
        }
        
        // Omit row identifier duplicated
        var customIdentifiers = Set<String>()
        
        for row in rowsWithCustomIdentifier {
            assert(customIdentifiers.insert(row.identifier).inserted)
        }
        
        for row in changeableRows {
            // Every changeable row should have an identifier
            assert(row.identifier != TableViewRow.defaultRowIdentifier)
            // Every changeable row must override determineCurrentValue().
            // The default method throws a fatalerror. We check if it doesn't throw.
            row.determineUpdateType()
        }
        
        var firstResponderRows = rows.compactMap { $0 as? TableViewRowTextField }
        
        firstResponderRows.removeAll(where: { !$0.isFirstResponder })
        
        assert(firstResponderRows.count <= 1, "No more than 1 table view row text field can be the first responder.")
        #endif
    }
    
    open override func reloadData() {
        jvDatasource.determineSectionsWithVisibleRows()
        
        super.reloadData()
    }
    
    func determineRowsWithoutTapHandlers() -> [TableViewRow] {
        return rowsWithCustomIdentifier
            .filter { $0.isSelectable }
            .filter { $0.tapped == nil }
            .filter { $0.showViewControllerOnTap == nil }
    }
    
    public func isValid() -> Bool {
        return rowInputValidators.allSatisfy { $0.validationState == .valid }
    }
    
    /// Call this once after you did setup the whole tableview & datasource.
    /// AND you have a header image view.
    /// If there is an header image, this view needs to be explicitly layout out.
    /// If this doesn't happen, the headerimage is shown half.
    /// I don't know the technical reason of why this is needed...
    public func correctHeaderImageAfterSetup() {
        layoutIfNeeded()
    }
    
    private func setup(headerImage: JVTableViewHeaderImage) {
        headerImage.loadableView.stretchImage()
        
        contentInset = UIEdgeInsets(top: headerImage.height, left: 0, bottom: 0, right: 0)
        
        addSubview(headerImage.loadableView)
    }
    
    private func updateHeaderStretchImageView() {
        guard let headerImage = headerImage else { return }
        
        var headerRect = CGRect(x: 0, y: -headerImage.height, width: bounds.width, height: headerImage.height)
        
        if contentOffset.y < -headerImage.height {
            headerRect.origin.y = contentOffset.y
            headerRect.size.height = -contentOffset.y
        }
        
        headerImage.loadableView.frame = headerRect
    }
    
    /// Checks if any row in the datasource has a different oldValue compared to its currentValue.
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
    
    /// Registers the unique cell types with there reuse identifier.
    private func registerUniqueCellTypes() {
        var insertedClassTypes: Set<String> = []
        
        for row in rows {
            let classIdentifier = row.classIdentifier
            
            guard insertedClassTypes.insert(classIdentifier).inserted else { break }
            
            // The cell hasn't been registered yet, do it now.
            register(row.classType, forCellReuseIdentifier: classIdentifier)
        }
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
        
        row.tapped!()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderStretchImageView()
    }

    open func retrieveChangeableRows() -> [TableViewRowUpdate] {
        return changeableRows.map { TableViewRowUpdate(changeableRow: $0) }
    }
}

private extension Bool {
    static func exactOneIsTrue(bools: Bool...) -> Bool {
        var foundTrue = false
        
        for bool in bools {
            guard bool else { continue }
            
            guard !foundTrue else { return false }
            
            foundTrue = true
        }
        
        return foundTrue
    }
}
