//
//  TVKIT_UITableViewCell.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
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
    
    internal var warningActive: Bool {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys.warningActive) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys.warningActive, newValue as Bool, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

}
