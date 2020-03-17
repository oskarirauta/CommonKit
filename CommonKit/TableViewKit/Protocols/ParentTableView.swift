//
//  ParentTableView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public protocol ParentTableViewProperties {
    
    var tableView: UITableView? { get set }
    var dataSource: UITableViewDataSource? { get }
    var controller: UIViewController? { get }
    var controllerProtocol: TableViewController? { get }
}

public protocol ParentTableViewCellProperties {
    
    var indexPath: IndexPath? { get }
}

public protocol ParentTableViewHeaderProperties {
    
    var headerSection: Int? { get }
    var footerSection: Int? { get }
    var section: Int? { get }
}

public protocol ParentTableViewMethods { }

public protocol ParentTableView: ParentTableViewProperties, ParentTableViewMethods { }

extension UITableViewCell: ParentTableView, ParentTableViewCellProperties {
    
    open var dataSource: UITableViewDataSource? {
        get { return self.tableView?.dataSource }
    }
    
    open var controller: UIViewController? {
        get {
            guard
                let _controller: UIViewController = self.dataSource as? UIViewController
                else { return nil }
            return _controller
        }
    }
    
    open var controllerProtocol: TableViewController? {
        get {
            guard
                let _delegate: TableViewController = self.controller as? TableViewController
                else { return nil }
            return _delegate
        }
    }
    
    open var indexPath: IndexPath? {
        get { return self.tableView?.indexPath(for: self) }
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.tableView = newSuperview as? UITableView
    }
    
    override open func removeFromSuperview() {
        super.removeFromSuperview()
        self.tableView = nil
    }
}

extension UITableViewHeaderFooterView: ParentTableView {
        
    open var dataSource: UITableViewDataSource? {
        get { return self.tableView?.dataSource }
    }
    
    open var controller: UIViewController? {
        get {
            guard
                let _controller = self.dataSource as? UIViewController
                else { return nil }
            return _controller
        }
    }
    
    open var controllerProtocol: TableViewController? {
        get {
            guard
                let delegate: TableViewController = self.controller as? TableViewController
                else { return nil }
            return delegate
        }
    }

    open var headerSection: Int? {
        get {
            guard let tableView: UITableView = self.tableView else { return nil }
            for index in 0..<tableView.numberOfSections {
                if tableView.headerView(forSection: index) == self { return index }
            }
            return nil
        }
    }

    open var footerSection: Int? {
        get {
            guard let tableView: UITableView = self.tableView else { return nil }
            for index in 0..<tableView.numberOfSections {
                if tableView.footerView(forSection: index) == self { return index }
            }
            return nil
        }
    }
    
    open var section: Int? {
        get {
            guard let tableView: UITableView = self.tableView else { return nil }
            for index in 0..<tableView.numberOfSections {
                if tableView.headerView(forSection: index) == self || tableView.footerView(forSection: index) == self { return index }
            }
            return nil
        }
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.tableView = newSuperview as? UITableView
    }
    
    override open func removeFromSuperview() {
        super.removeFromSuperview()
        self.tableView = nil
    }
}

