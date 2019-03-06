//
//  BrowsableCellProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

@objc public protocol BrowsableCellProtocolBase {
    func prevField(_ sender: Any)
    func nextField(_ sender: Any)
}

public protocol BrowsableCellProtocol: BrowsableCellProtocolBase {
    var prevIndex: IndexPath? { get set }
    var nextIndex: IndexPath? { get set }
    var browsingDisabled: Bool { get set }
}

extension UITableViewCell: BrowsableCellProtocol {
    
    @objc open var browsingDisabled: Bool {
        get { return self._browsingDisabled }
        set { self._browsingDisabled = newValue }
    }
    
    @objc open var prevIndex: IndexPath? {
        get {
            guard let section: Int = self.prevSection, let row: Int = self.prevRow else { return nil }
            return IndexPath(row: row, section: section)
        }
        set {
            guard newValue != nil else {
                self.prevRow = nil
                self.prevSection = nil
                return
            }
            self.prevRow = newValue!.row
            self.prevSection = newValue!.section
        }
    }

    @objc open var nextIndex: IndexPath? {
        get {
            guard let section: Int = self.nextSection, let row: Int = self.nextRow else { return nil }
            return IndexPath(row: row, section: section)
        }
        set {
            guard newValue != nil else {
                self.nextRow = nil
                self.nextSection = nil
                return
            }
            self.nextRow = newValue!.row
            self.nextSection = newValue!.section
        }
    }
    
    open func prevField(_ sender: Any) {
        guard self.prevIndex != nil else { return }
        self.tableView?.endEditing(true)
        self.tableView?.selectRow(at: self.prevIndex!, animated: true, scrollPosition: .middle)
    }
    
    open func nextField(_ sender: Any) {
        guard self.nextIndex != nil else { return }
        self.tableView?.endEditing(true)
        self.tableView?.selectRow(at: self.nextIndex!, animated: true, scrollPosition: .middle)
    }
    
}
