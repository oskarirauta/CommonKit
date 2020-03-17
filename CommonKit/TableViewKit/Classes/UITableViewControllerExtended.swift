//
//  UITableViewControllerExtended.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewController {
    
    open class Extended: UIViewController, TableViewConfig, ViewControllerConfig, TableViewControllerConfig, BackButton, TableViewController {
                
        private lazy var _tableView: UITableView = ((self as TableViewControllerConfig?)?.tableViewOverride ?? ((self as TableViewControllerConfig?)?.tableViewStyle ?? ( self._initializedStyle ?? .grouped )).tableView.properties {
            tableView in
            tableView.delegate = self.delegate
            tableView.dataSource = self.dataSource
            tableView.keyboardDismissMode = .interactive
            tableView.allowsSelectionDuringEditing = true
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.contentInsetAdjustmentBehavior = .automatic
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (self as TableViewControllerConfig?)?.bottomSpacing ?? 260.0, right: 0)
            tableView.allowsMultipleSelection = false
            tableView.allowsMultipleSelectionDuringEditing = false
            tableView.bounces = true
            (self as TableViewControllerConfig?)?.cellReuseIdentifiers?.forEach {
                tableView.register($0.value, forCellReuseIdentifier: $0.key)
            }
            (self as TableViewControllerConfig?)?.headerReuseIdentifiers?.forEach {
                tableView.register($0.value, forHeaderFooterViewReuseIdentifier: $0.key)
            }
        }).properties {
            (self as TableViewConfig?)?._tableViewConfig?($0)
            (self as TableViewConfig?)?.tableViewConfig?($0)
        }

        private var _initializedStyle: UITableView.Style? = nil

        open lazy var delegate: UITableViewDelegate? = { return self as UITableViewDelegate? }()
        open lazy var dataSource: UITableViewDataSource? = { return self as UITableViewDataSource? }()
        
        open var tableView: UITableView! {
            get { return self._tableView }
            set { self._tableView = newValue }
        }
        
        open var style: UITableView.Style {
            get { return self.tableView.style }
        }
        
        open var refreshControl: UIRefreshControl? {
            get { return self.tableView.refreshControl }
            set { self.tableView.refreshControl = newValue }
        }
        
        open var indexPathsForVisibleRows: [IndexPath]? {
            get { return self.tableView.indexPathsForVisibleRows }
        }
        
        open var visibleCells: [UITableViewCell] {
            get { return self.tableView.visibleCells }
        }
        
        open var _backButton: UIBackButton? = nil
        open var editingSection: Int? = nil
        
        override open var isEditing: Bool {
            get { return self.tableView.isEditing }
            set { self.setEditing(newValue, animated: true) }
        }

        open var contentOffset: CGPoint {
            get { return self.tableView.contentOffset }
            set { self.tableView.contentOffset = newValue }
        }
        
        open var topOffset: CGPoint {
            get { return CGPoint(x: 0, y: -self.tableView.adjustedContentInset.top) }
        }
        
        public required init(style: UITableView.Style) {
            self._initializedStyle = style
            super.init(nibName: nil, bundle: nil)
            (self as ViewControllerConfig?)?._viewControllerConfig?(self)
            (self as ViewControllerConfig?)?.viewControllerConfig?(self)
        }
        
        public required init() {
            super.init(nibName: nil, bundle: nil)
            (self as ViewControllerConfig?)?._viewControllerConfig?(self)
            (self as ViewControllerConfig?)?.viewControllerConfig?(self)
        }
        
        override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nil, bundle: nil)
            (self as ViewControllerConfig?)?._viewControllerConfig?(self)
            (self as ViewControllerConfig?)?.viewControllerConfig?(self)
        }
        
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        open func backAction() {
            self.navigationController?.popViewController(animated: true)
        }
        
        override open func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.addSubview(self.tableView)
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }

        override open func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationItem.leftBarButtonItem = ( self.navigationController?.viewControllers.count ?? 0 ) < 2 ? nil : self.backButton
            
            if ( self as TableViewControllerConfig?)?.clearsSelectionOnViewWillAppear ?? true {
                self.tableView.indexPathsForSelectedRows?.forEach {
                    self.tableView.deselectRow(at: $0, animated: false)
                }
            }
        }

        override open func viewWillDisappear(_ animated: Bool) {
            if self.tableView.isEditing { self.tableView.setEditing(false, animated: false) }
            self.editingSection = nil
            super.viewWillDisappear(animated)
        }
        
        open func reloadData() {
            self.tableView.reloadData()
        }

        /* Tableview data source */
        open func numberOfSections(in tableView: UITableView) -> Int {
            return 0
        }
        
        open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return nil
        }
        
        open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return nil
        }
        
        open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        open func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
            return 0
        }
        
        open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { }
        
        open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }

        open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
            return (self as TableViewControllerConfig?)?.headerHeight ?? ( UIDevice.deviceFamily.iphoneCompatible ? 25.0 : 50.0 )
        }
        
        open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
            return (self as TableViewControllerConfig?)?.footerHeight ?? ( UIDevice.deviceFamily.iphoneCompatible ? 25.0 : 50.0 )
        }
        
        open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return (self as TableViewControllerConfig?)?.rowHeight ?? ( UIDevice.deviceFamily.iphoneCompatible ? 38.0 : 76.0 )
        }
        
        open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return false
        }
        
        open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        }
        
        open func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt targetIndexPathForMoveFromRowAtIndexPath: IndexPath, toProposedIndexPath: IndexPath) -> IndexPath {
            
            return toProposedIndexPath
        }
        
        open func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
            tableView.moveRow(at: fromIndexPath, to: to)
        }
        
        open func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            return false
        }
        
        open func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
        }
        
        open func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
            return true
        }

        open func cell(for reuseIdentifier: String) -> UITableViewCell {
            guard let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
                fatalError("Cell reuse identifier \"" + reuseIdentifier + "\" is not registered with this controller.")
            }
            return cell
        }
        
        open func header(for reuseIdentifier: String) -> UITableViewHeaderFooterView {
            guard let header: UITableViewHeaderFooterView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) else {
                fatalError("Header reuse identifier \"" + reuseIdentifier + "\" is not registered with this controller.")
            }
            return header
        }

        open func numSections(_ tableView: UITableView? = nil) -> Int {
            return self.numberOfSections(in: tableView ?? self.tableView)
        }

        open func numRows(_ tableView: UITableView? = nil, in section: Int) -> Int {
            guard section < self.numSections(tableView) else { return 0 }
            return self.tableView(tableView ?? self.tableView, numberOfRowsInSection: section)
        }
        
        open func hasIndexPath(_ tableView: UITableView? = nil, at indexPath: IndexPath) -> Bool {
            return indexPath.section < (tableView ?? self.tableView).numberOfSections && indexPath.row < (tableView ?? self.tableView).numberOfRows(inSection: indexPath.section)
        }
        
        open func indexPathIsVisible(_ tableView: UITableView? = nil, at indexPath: IndexPath) -> Bool {
            guard self.hasIndexPath(tableView, at: indexPath) else { return false }
            return (tableView ?? self.tableView).indexPathsForVisibleRows?.contains(indexPath) ?? false
        }

        open func indexPath(_ tableView: UITableView? = nil, for: UITableViewCell) -> IndexPath? {
            return (tableView ?? self.tableView).indexPath(for: `for`)
        }

        open func setEditingSection(section: Int?) {
            self.editingSection = section
        }
                
        open func setContentOffset(contentOffset: CGPoint, animated: Bool) {
            if !animated { self.tableView.layer.removeAllAnimations() }
            self.tableView.setContentOffset(contentOffset, animated: animated)
        }
        
        open func setEditing(_ editing: Bool, animated: Bool, section: Int? = nil) {
            self.editingSection = !editing ? nil : section
            self.tableView.setEditing(editing, animated: animated)
        }
        
        open func toggleEditing(for section: Int, animated: Bool = true) {
            self.endEditing(true)

            if self.tableView.isEditing, self.editingSection == section {
                self.editingSection = nil
                self.tableView.setEditing(false, animated: animated)
            } else if !self.tableView.isEditing {
                self.editingSection = section
                self.tableView.setEditing(true, animated: animated)
            } else if self.tableView.isEditing, self.editingSection != section {
                self.tableView.setEditing(false, animated: animated)
                self.editingSection = section
                self.tableView.setEditing(true, animated: animated)
            } else {
                self.editingSection = nil
                self.tableView.setEditing(false, animated: animated)
            }
        }
        
        open func endEditing(_ force: Bool = true, animated: Bool = true) {
            self.tableView.endEditing(force)
            self.view.endEditing(force)
            guard self.tableView.isEditing else { return }
            self.editingSection = nil
            self.tableView.setEditing(false, animated: animated)
        }
                
        open func endEditing() {
            self.endEditing(true, animated: true)
        }
        
        open func scrollToTop(animated: Bool = true) {
            self.setContentOffset(contentOffset: self.topOffset, animated: animated)
        }
        
        open func scrollToBottom(section: Int, animated: Bool = true, at: UITableView.ScrollPosition = .bottom) {
            
            let csz: CGSize = self.tableView.contentSize
            let bsz: CGSize = self.tableView.bounds.size
            let bottomInset: CGFloat = self.tableView.contentInset.bottom

            if self.tableView.contentOffset.y + bsz.height + bottomInset > csz.height {
                self.tableView.setContentOffset(CGPoint(x: 0, y: csz.height - bsz.height + bottomInset), animated: animated)
            }
        }
        
        open func scrollToFirstRow(animated: Bool = true) {
            guard
                let indexPath: IndexPath = IndexPath(row: 0, section: 0) as IndexPath?,
                self.hasIndexPath(at: indexPath)
                else { return }
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: animated)
        }

        open func scrollToRow(at indexPath: IndexPath, at: UITableView.ScrollPosition = .top, animated: Bool = true) {
            guard self.hasIndexPath(at: indexPath) else { return }
            self.tableView.scrollToRow(at: indexPath, at: at, animated: animated)
        }
        
    }
    
}
