//
//  TableViewControllerProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public protocol TableViewControllerProtocol: UITableViewDelegate, UITableViewDataSource, TableViewSettingsProtocol {
    
    var delegate: UITableViewDelegate? { get set }
    var datasource: UITableViewDataSource? { get set }
    
    var editingSection: Int? { get set }
    
    var isEditing: Bool { get set }
    
    func setEditingSection(section: Int?)
    func setEditing(_ editing: Bool, animated: Bool, section: Int? )
    func setEditing(_ editing: Bool, animated: Bool)
    func toggleEditing(for section: Int, animated: Bool)
    func endEditing(_ force: Bool)
    func endEditing()
    
    func reloadData()
    
    func scrollToTop(animated: Bool)
    func scrollToTop(section: Int, animated: Bool)
    func scrollToBottom(section: Int, animated: Bool, at: UITableViewScrollPosition)
    func scrollToRow(at indexPath: IndexPath, at: UITableViewScrollPosition, animated: Bool)
}

protocol InternalTableViewControllerProtocol: TableViewControllerProtocol, InternalTableViewSettingsProtocol { }

extension TableViewControllerProtocol {
    
    public func setEditingSection(section: Int?) {
        self.editingSection = section
    }
    
    public var isEditing: Bool {
        get { return self.tableView.isEditing }
        set { self.setEditing(newValue, animated: true) }
    }
    
    public func setEditing(_ editing: Bool, animated: Bool, section: Int? ) {
        self.editingSection = !editing ? nil : section
        self.tableView.setEditing(editing, animated: animated)
    }
    
    public func setEditing(_ editing: Bool, animated: Bool) {
        self.editingSection = nil
        self.tableView.setEditing(editing, animated: animated)
    }
    
    public func toggleEditing(for section: Int, animated: Bool = true) {
        let isEditing: Bool = self.tableView.isEditing
        let editingSection: Int? = self.editingSection
        self.endEditing(true)
        
        if (( isEditing ) && ( editingSection == section )) {
            self.editingSection = nil
            self.tableView.setEditing(false, animated: animated)
        } else if ( !isEditing ) {
            self.editingSection = section
            self.tableView.setEditing(true, animated: animated)
        } else if (( isEditing ) && ( editingSection != section )) {
            self.tableView.setEditing(false, animated: animated)
            self.editingSection = section
            self.tableView.setEditing(true, animated: animated)
        } else {
            self.editingSection = nil
            self.tableView.setEditing(false, animated: animated)
        }
    }
    
    public func endEditing(_ force: Bool = true) {
        self.tableView.endEditing(force)
        if let vc = self as? UIViewController { vc.view.endEditing(force) }
        if ( self.tableView.isEditing ) {
            self.editingSection = nil
            self.tableView.setEditing(false, animated: true)
        }
    }
    
    public func endEditing() {
        self.endEditing(true)
    }
    
    public func scrollToTop(animated: Bool) {
        if (( self.tableView.numberOfSections >= 1 ) && ( self.tableView.numberOfRows(inSection: 0) > 0 )) {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: animated)
        }
    }
    
    public func scrollToTop(section: Int, animated: Bool) {
        self.tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
    }
    
    public func scrollToBottom(section: Int, animated: Bool, at: UITableViewScrollPosition = .bottom) {
        
        let csz: CGSize = self.tableView.contentSize
        let bsz: CGSize = self.tableView.bounds.size
        let bottomInset: CGFloat = self.tableView.contentInset.bottom
        
        if ( self.tableView.contentOffset.y + bsz.height + bottomInset > csz.height ) {
            self.tableView.setContentOffset(CGPoint(x: 0, y: csz.height - bsz.height + bottomInset), animated: animated)
        }
    }
    
    public func scrollToRow(at indexPath: IndexPath, at: UITableViewScrollPosition = .top, animated: Bool = true) {
        
        if ( self.tableView.cellForRow(at: indexPath) != nil ) {
            self.tableView.scrollToRow(at: indexPath, at: at, animated: animated)
        }
    }
}
