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
    
    var contentOffset: CGPoint { get set }
    var topOffset: CGPoint { get }
    
    func numSections() -> Int
    func numRows(in section: Int) -> Int
    func hasIndexPath(_ indexPath: IndexPath) -> Bool

    func setEditingSection(section: Int?)
    func setEditing(_ editing: Bool, animated: Bool, section: Int? )
    func setEditing(_ editing: Bool, animated: Bool)
    func toggleEditing(for section: Int, animated: Bool)
    func endEditing(_ force: Bool)
    func endEditing()
    
    func reloadData()
    
    func setContentOffset(contentOffset: CGPoint, animated: Bool)
    func scrollToTop(animated: Bool)
    func scrollToBottom(section: Int, animated: Bool, at: UITableView.ScrollPosition)
    func scrollToFirstRow(animated: Bool)
    func scrollToRow(at indexPath: IndexPath, at: UITableView.ScrollPosition, animated: Bool)
}

protocol InternalTableViewControllerProtocol: TableViewControllerProtocol, InternalTableViewSettingsProtocol { }

extension TableViewControllerProtocol {
    
    public func numSections() -> Int {
        return self.numberOfSections!(in: self.tableView)
    }

    public func numRows(in section: Int) -> Int {
        guard section < self.numSections() else { return 0 }
        return self.tableView(self.tableView, numberOfRowsInSection: section)
    }
    
    
    public func setEditingSection(section: Int?) {
        self.editingSection = section
    }
    
    public var isEditing: Bool {
        get { return self.tableView.isEditing }
        set { self.setEditing(newValue, animated: true) }
    }

    public var contentOffset: CGPoint {
        get { return self.tableView.contentOffset }
        set { self.tableView.contentOffset = newValue }
    }
    
    public var topOffset: CGPoint {
        get {
            if #available(iOS 11.0, *) {
                return CGPoint(x: 0, y: -self.tableView.adjustedContentInset.top)
            } else {
                return CGPoint(x: 0, y: -self.tableView.contentInset.top)
            }
        }
    }

    public func hasIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section < self.tableView.numberOfSections && indexPath.row < self.tableView.numberOfRows(inSection: indexPath.section)
    }
    
    public func setContentOffset(contentOffset: CGPoint, animated: Bool) {
        if !animated { self.tableView.layer.removeAllAnimations() }
        self.tableView.setContentOffset(contentOffset, animated: animated)
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
        self.setContentOffset(contentOffset: self.topOffset, animated: animated)
    }
    
    public func scrollToBottom(section: Int, animated: Bool, at: UITableView.ScrollPosition = .bottom) {
        
        let csz: CGSize = self.tableView.contentSize
        let bsz: CGSize = self.tableView.bounds.size
        let bottomInset: CGFloat = self.tableView.contentInset.bottom
        
        if ( self.tableView.contentOffset.y + bsz.height + bottomInset > csz.height ) {
            self.tableView.setContentOffset(CGPoint(x: 0, y: csz.height - bsz.height + bottomInset), animated: animated)
        }
    }
    
    public func scrollToFirstRow(animated: Bool) {
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        guard self.hasIndexPath(indexPath) else { return }
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: animated)
    }

    public func scrollToRow(at indexPath: IndexPath, at: UITableView.ScrollPosition = .top, animated: Bool = true) {
        guard self.hasIndexPath(indexPath) else { return }
        self.tableView.scrollToRow(at: indexPath, at: at, animated: animated)
    }
}
