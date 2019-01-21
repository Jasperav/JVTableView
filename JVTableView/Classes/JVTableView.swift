import UIKit
import JVConstraintEdges
import JVTappable
import JVView
import JVFormChangeWatcher
import JVLoadableImage

open class JVTableView: UITableView, ChangeableForm {
    
    public static var standardOptions: JVTableViewOptions!
    
    open var helper: JVTableViewHelper!
    
    public var formHasChanged: ((_ hasNewValues: Bool) -> ())?
    public private (set) var jvDatasource: JVTableViewDatasource!
    public private (set) var options: JVTableViewOptions!
    public private (set) var headerStretchImage: JVTableViewHeaderStretchImage?
    public private (set) var headerStretchView: LoadableImage?
    
    public init(datasource: JVTableViewDatasource,
                options: JVTableViewOptions = JVTableView.standardOptions!,
                headerStretchImage: JVTableViewHeaderStretchImage? = nil) {
        super.init(frame: CGRect.zero, style: .grouped)
        
        initialize(datasource: datasource, options: options, headerStretchImage: headerStretchImage)
        commonLoad()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Call this in the awakeFromNib() before calling super.awakeFromNib()
    public func initialize(datasource: JVTableViewDatasource,
                           options: JVTableViewOptions = JVTableView.standardOptions!,
                           headerStretchImage: JVTableViewHeaderStretchImage? = nil) {
        assert(self.options == nil)
        
        self.options = options
        self.headerStretchImage = headerStretchImage
        jvDatasource = datasource
        
        helper = JVTableViewHelper(tableView: self)
        helper.registerDefaultCells()
        
        guard let headerStretchImage = headerStretchImage else { return }
        
        add(headerStretchImage: headerStretchImage)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        assert(jvDatasource != nil, "Call initialize() first in the awakeFromNib method.")
        
        commonLoad()
    }
    
    private func commonLoad() {
        sectionFooterHeight = UITableView.automaticDimension
        estimatedSectionFooterHeight = 5
        
        dataSource = self
        delegate = self
        
        tableFooterView = UIView()
        
        reloadData()
    }
    
    open override func reloadData() {
        jvDatasource.determineSectionsWithVisibleRows()
        
        super.reloadData()
    }
    
    private func add(headerStretchImage: JVTableViewHeaderStretchImage) {
        headerStretchView = LoadableImage(style: .gray, rounded: false)
        
        headerStretchView!.stretchImage()
        
        contentInset = UIEdgeInsets(top: headerStretchImage.height, left: 0, bottom: 0, right: 0)
        
        addSubview(headerStretchView!)
        
        updateHeaderStretchImageView()
        
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
}

extension JVTableView: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return jvDatasource.dataSourceVisibleRows.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jvDatasource.dataSourceVisibleRows[section].rows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = jvDatasource.getRow(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: row.classIdentifier, for: indexPath)
        
        row.isVisible?(cell)
        
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
    
    //    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        // Return an empty UIView() if there is no footerText because else we get a weird gray square...
    //        guard let text = jvDatasource.getSection(section).footerText else {
    //            return UIView()
    //        }
    //
    //        return helper.determineFooterView(text: text)
    //    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = jvDatasource.getRow(indexPath)
        
        return cell.isSelectable ? indexPath : nil
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // If a row is selectable, is SHOULD ALWAYS BE TAPPEABLE
        (jvDatasource.getRow(indexPath) as! Tappable).tapped!()
        
        // Instant deselect the row, maybe this isn't always useful if multiple rows needs to be selected.
        deselectRow(at: indexPath, animated: false)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderStretchImageView()
    }
    
}
