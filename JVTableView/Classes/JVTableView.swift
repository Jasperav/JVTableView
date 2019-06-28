import UIKit
import JVConstraintEdges
import JVView
import JVFormChangeWatcher
import JVLoadableImage
import JVChangeableValue
import JVNoParameterInitializable
import JVInputValidator
import os
import JVDebugProcessorMacros

open class JVTableView<U: JVTableViewDatasource>: UITableView, ChangeableForm, UITableViewDataSource, UITableViewDelegate {
    
    /// Will be called when anything in the form has been changed.
    /// Not mandatory when you have a screen which won't update directly
    /// When the screen disappears, the save method will be called
    /// With an array of changed rows.
    /// This property is usefull when you want to be directly notified if anything in the form has changed.
    public var formHasChanged: ((_ hasNewValues: Bool) -> ())?
    
    /// The header stretch view which will maintain the stretch image.
    public private (set) var headerImage: JVTableViewHeaderImage?
    
    /// Don't modify rows directly.
    public let jvDatasource: U
    
    /// Contains all the rows of jvDatasource.
    let rows: [TableViewRow]
    
    /// Contains all the rows of jvDatasource which rowIdentifier isn't set to the default ("").
    let rowsWithCustomIdentifier: [TableViewRow]
    
    /// Contains all the rows of jvDatasource which conforms to the protocol Changeable.
    let changeableRows: [TableViewRow & Changeable]
    
    var rowsWithoutTapHandlers: [TableViewRow] {
        return rowsWithCustomIdentifier
            .filter { $0.isSelectable() }
            .filter { $0.tapped == nil }
            .filter { $0.showViewControllerOnTap == nil }
    }
    
    let firstResponderTableViewRowIdentifier: String?
    
    /// Contains all the rows of jvDatasource which conforms to the protocol InputValidateable.
    private let rowInputValidators: [InputValidator]
    
    public var rowsAreValid: Bool {
        return rowInputValidators.allSatisfy { $0.validationState == .valid }
    }
    
    public init(datasource tempJVDatasource: U) {
        rows = tempJVDatasource.dataSource.flatMap { $0.rows }
        
        rowsWithCustomIdentifier = rows.filter { $0.identifier != TableViewRow.defaultRowIdentifier }
        changeableRows = rows.compactMap { $0 as? TableViewRow & Changeable }
        rowInputValidators = rows.compactMap { $0 as? InputValidateable }.map { $0.inputValidator }
        
        firstResponderTableViewRowIdentifier = rowsWithCustomIdentifier.compactMap { $0 as? TableViewRowTextField }.first(where: { $0.isFirstResponder })?.identifier
        
        jvDatasource = tempJVDatasource
        
        super.init(frame: CGRect.zero, style: jvDatasource.style)
        
        headerImage = jvDatasource.headerImage

        for row in rows {
            row.commonLoad()
        }
        
        registerUniqueCellTypes()
        
        sectionFooterHeight = UITableView.automaticDimension
        estimatedSectionFooterHeight = 5
        
        jvDatasource.prepareForReload()
        dataSource = self
        delegate = self
        keyboardDismissMode = .onDrag
        
        tableFooterView = UIView()
        
        #if DEBUG
        validate()
        #endif
        
        guard let headerImage = headerImage else { return }
        
        setup(headerImage: headerImage)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    #if DEBUG
    public func validate() {
        for row in rows.compactMap({ $0 as? Changeable & TableViewRow }) {
            assert(row.identifier != TableViewRow.defaultRowIdentifier, "A changeable row should always have an identifier \(row.identifier)")
        }

        // Omit row identifier duplicated
        var customIdentifiers = Set<String>()
        
        for row in rowsWithCustomIdentifier {
            if !customIdentifiers.insert(row.identifier).inserted {
                os_log("Duplicate row identifiers found. These are the row identifiers: ", type: .debug)
                for row in rowsWithCustomIdentifier {
                    os_log("%{private}@", type: .debug, row.identifier)
                }
                
                os_log("Now crashing", type: .debug)
                
                assert(false)
            }
        }
        
        var firstResponderRows = rows.compactMap { $0 as? TableViewRowTextField }
        
        firstResponderRows.removeAll(where: { !$0.isFirstResponder })
        
        assert(firstResponderRows.count <= 1, "No more than 1 table view row text field can be the first responder.")
    }
    #endif
    
    open override func reloadData() {
        jvDatasource.updateVisibleRows()

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
    
    private func updateHeaderStretchImageView() {
        guard let headerImage = headerImage else { return }
        
        let rect: CGRect
        
        if contentOffset.y < -headerImage.height {
            rect = CGRect(x: 0, y: contentOffset.y, width: bounds.width, height: -contentOffset.y)
        } else {
            rect = CGRect(x: 0, y: -headerImage.height, width: bounds.width, height: headerImage.height)
        }
        
        headerImage.loadableView.frame = rect
    }
    
    /// Checks if any row in the datasource has a different oldValue compared to its currentValue.
    private func checkIfFormChanged() {
        formHasChanged?(changeableRows.contains(where: { $0.isChanged }))
    }
    
    /// Registers the unique cell types with there reuse identifier.
    private func registerUniqueCellTypes() {
        var insertedClassTypes: Set<String> = []
        
        for row in rows {
            let classIdentifier = row.classIdentifier
            
            guard insertedClassTypes.insert(classIdentifier).inserted else { continue }
            
            // The cell hasn't been registered yet, do it now.
            register(row.classType, forCellReuseIdentifier: classIdentifier)
        }
    }
    
    /// Resets everything to the oldValues
    /// Set reloadData to true after a whole update. This is false by default because:
    /// when a user is typing something a textField and that textField has at a moment the same oldValue and newValue,
    /// The keyboard disappears.
    public func resetForm(reloadData: Bool = false) {
        for row in changeableRows {
            row.reset()
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
            changeableRow.hasChanged = { [unowned self] (_) in
                self.checkIfFormChanged()
                
                if let switchCell = row as? TableViewRowLabelSwitch {
                    let rows = switchCell.hideRows(switchCell.currentValue)
                    
                    guard !rows.isEmpty else { return }
                    
                    var inserts = [IndexPath]()
                    var deletes = [IndexPath]()
                    
                    for someRow in rows {
                        let matchingRow = self.rows.first(where: { $0.identifier == someRow.identifier })!
                        let isVisible = matchingRow.isVisible()
                        
                        if isVisible && someRow.hide {
                            deletes.append(self.jvDatasource.indexPathForVisibleCell(identifier: someRow.identifier))
                            matchingRow.isVisible = { return false }
                        } else if !isVisible && !someRow.hide {
                            inserts.append(self.jvDatasource.indexPath(identifier: someRow.identifier))
                            matchingRow.isVisible = { return true }
                        }
                    }
                    
                    self.jvDatasource.updateVisibleRows()
                    tableView.performBatchUpdates({
                        tableView.deleteRows(at: deletes, with: .automatic)
                        tableView.insertRows(at: inserts, with: .automatic)
                    })
                }
            }
        }
        
        cell.selectionStyle = row.isSelectable() ? UITableViewCell.SelectionStyle.gray : .none
        
        return cell
    }
    
    public func reloadRow(identifier: String) {
        guard let cell = (visibleCells as! [TableViewCell]).first(where: { $0.identifier! == identifier }), let indexPath = indexPath(for: cell) else {
            assert(false)
            return
        }
        
        reloadRows(at: [indexPath], with: .none)
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return jvDatasource.getSection(section).header
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return jvDatasource.getSection(section).footerText
    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = jvDatasource.getRow(indexPath)
        
        return cell.isSelectable() ? indexPath : nil
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = jvDatasource.getRow(indexPath)
        
        row._tapped!()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderStretchImageView()
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension JVTableView: ViewLayout {
    private func setup(headerImage: JVTableViewHeaderImage) {
        contentInset = UIEdgeInsets(top: headerImage.height, left: 0, bottom: 0, right: 0)
        
        addSubview(headerImage.loadableView)
        // Removing space between the image and first cell
        tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 0.01)))
    }
}

public extension UITableView {
    func deselectCurrentRow(animated: Bool) {
        guard let row = indexPathForSelectedRow else {
            return
        }
        
        deselectRow(at: row, animated: animated)
    }
}
