//
//  UITableViewCellExtended.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    open class Extended: UITableViewCell, TableViewCell {
        
        open var cellConstraints: [String: NSLayoutConstraint] = [:]
        open var handler: CellHandler = nil
    
        override open func prepareForReuse() {
            super.prepareForReuse()
            self.cellConstraints = [:]
            self.handler = nil
            self.cellProperties()
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.tableView = nil
            self.cellProperties()
            self.setupViews()
            self.secondarySetupViews()
            self.setupConstraints()
            self.secondaryConstraints()
            (self as CellConstraints).updateCellConstraints?()
            self.activateCellConstraints()
            self.setNeedsUpdateConstraints()
        }
        
        override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.tableView = nil
            self.cellProperties()
            self.setupViews()
            self.secondarySetupViews()
            self.setupConstraints()
            self.secondaryConstraints()
            (self as CellConstraints).updateCellConstraints?()
            self.activateCellConstraints()
            self.setNeedsUpdateConstraints()
        }
        
        override open func setHighlighted(_ highlighted: Bool, animated: Bool) {}
        
        override open func setSelected(_ selected: Bool, animated: Bool) {
            guard self.selectable, self.enabled else { return }
            
            if (( self.tableView != nil ) && ( self.tableView!.isEditing ) && (( self.controller as? TableViewController)?.editingSection == self.indexPath?.section )) {
                return
            }
            
            (self as SelectableCell?)?.internalSetSelected?(selected, animated: animated)
        }

        open func activateCellConstraints(_ key: String? = nil) {
            
            guard
                let _key: String = key,
                self.cellConstraints.has(key: _key)
                else {
                    if key == nil { self.cellConstraints.values.forEach { $0.isActive = true }}
                    return
                }
            self.cellConstraints[_key]?.isActive = true
        }
        
        open func deactivateCellConstraints(_ key: String? = nil) {
            
            guard
                let _key: String = key,
                self.cellConstraints.has(key: _key)
                else {
                    if key == nil { self.cellConstraints.values.forEach { $0.isActive = false }}
                    return
                }
            self.cellConstraints[_key]?.isActive = false
        }

        open func returnValues() -> CellReturn {
            return CellReturn(cell: self)
        }
        
    }
}

extension UITableViewCell: BrowsableCell {
    
    private struct TV_AssociatedKeys {
        static var _tableView: UITableView? = nil
        static var selectable: Bool = false
        static var enabled: Bool = true
        static var uuid: String? = nil
        static var editingSection: Int? = nil
        static var prevSection: Int? = nil
        static var prevRow: Int? = nil
        static var nextSection: Int? = nil
        static var nextRow: Int? = nil
        static var browsingDisabled: Bool = false
        static var warningActive: Bool = false
    }
    
    open var tableView: UITableView? {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys._tableView) as? UITableView }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys._tableView, newValue as UITableView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    open var editingSection: Int? {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys.editingSection) as? Int }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys.editingSection, newValue as Int?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    open var uuid: String? {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys.uuid) as? String }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys.uuid, newValue as String?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    open var selectable: Bool {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys.selectable) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys.selectable, newValue as Bool, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    open var enabled: Bool {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys.enabled) as? Bool ?? true }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys.enabled, newValue as Bool, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    internal var prevSection: Int? {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys.prevSection) as? Int }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys.prevSection, newValue as Int?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    internal var prevRow: Int? {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys.prevRow) as? Int }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys.prevRow, newValue as Int?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    internal var nextSection: Int? {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys.nextSection) as? Int }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys.nextSection, newValue as Int?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    internal var nextRow: Int? {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys.nextRow) as? Int }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys.nextRow, newValue as Int?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    internal var _browsingDisabled: Bool {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys.browsingDisabled) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys.browsingDisabled, newValue as Bool, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    open var warningActive: Bool {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys.warningActive) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys.warningActive, newValue as Bool, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    open var browsingDisabled: Bool {
        get { return self._browsingDisabled }
        set { self._browsingDisabled = newValue }
    }
    
    open var prevIndex: IndexPath? {
        get {
            guard
                let section: Int = self.prevSection,
                let row: Int = self.prevRow
                else { return nil }
            return IndexPath(row: row, section: section)
        }
        set {
            self.prevRow = newValue?.row ?? nil
            self.prevSection = newValue?.section ?? nil
        }
    }

    open var nextIndex: IndexPath? {
        get {
            guard
                let section: Int = self.nextSection,
                let row: Int = self.nextRow
                else { return nil }
            return IndexPath(row: row, section: section)
        }
        set {
            self.nextRow = newValue?.row ?? nil
            self.prevRow = newValue?.section ?? nil
        }
    }
    
}

extension UITableViewCell {
    
    @objc open func prevField(_ sender: Any) {
        guard let prevIndex: IndexPath = self.prevIndex else { return }
        self.tableView?.endEditing(true)
        self.tableView?.selectRow(at: prevIndex, animated: true, scrollPosition: .middle)
    }
    
    @objc open func nextField(_ sender: Any) {
        guard let nextIndex: IndexPath = self.nextIndex else { return }
        self.tableView?.endEditing(true)
        self.tableView?.selectRow(at: nextIndex, animated: true, scrollPosition: .middle)
    }

}
