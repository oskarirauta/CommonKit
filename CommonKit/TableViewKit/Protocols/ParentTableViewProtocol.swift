//
//  ParentTableViewProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public protocol ParentTableViewProtocol: class {
    var tableView: UITableView? { get set }
}

extension UITableViewCell: ParentTableViewProtocol {
    
    open var datasource: UITableViewDataSource? {
        get { return self.tableView?.dataSource }
    }
    
    open var controller: UIViewController? {
        get {
            if let _controller = self.datasource as? UIViewController {
                return _controller
            }
            return nil
        }
    }
    
    open var controllerProtocol: TableViewControllerProtocol? {
        get {
            guard let delegate: TableViewControllerProtocol = self.controller as? TableViewControllerProtocol else { return nil }
            return delegate
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

extension UITableViewHeaderFooterView: ParentTableViewProtocol {
        
    open var datasource: UITableViewDataSource? {
        get { return self.tableView?.dataSource }
    }
    
    open var controller: UIViewController? {
        get {
            if let _controller = self.datasource as? UIViewController {
                return _controller
            }
            return nil
        }
    }
    
    open var controllerProtocol: TableViewControllerProtocol? {
        get {
            guard let delegate: TableViewControllerProtocol = self.controller as? TableViewControllerProtocol else { return nil }
            return delegate
        }
    }

    open var headerSection: Int? {
        get {
            guard self.tableView != nil else { return nil }
            for index in 0..<self.tableView!.numberOfSections {
                if ( self.tableView?.headerView(forSection: index) == self ) { return index }
            }
            return nil
        }
    }

    open var footerSection: Int? {
        get {
            guard self.tableView != nil else { return nil }
            for index in 0..<self.tableView!.numberOfSections {
                if ( self.tableView?.footerView(forSection: index) == self ) { return index }
            }
            return nil
        }
    }
    
    open var section: Int? {
        get {
            guard let hdrSection: Int = self.headerSection else { return self.footerSection }
            return hdrSection
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

