//
//  UITableViewControllerExtended.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewControllerExtended {
    
    internal func defaultTableView() -> UITableView {
        return UITableView(frame: .zero, style: self._tableViewStyle).properties {
            tv in
            tv.delegate = self.delegate
            tv.dataSource = self.datasource
            tv.keyboardDismissMode = .interactive
            tv.allowsSelectionDuringEditing = true
            tv.translatesAutoresizingMaskIntoConstraints = false
            tv.contentInsetAdjustmentBehavior = .automatic
            tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self._defaultBottomSpacing, right: 0)
            tv.allowsMultipleSelection = false
            tv.allowsMultipleSelectionDuringEditing = false
            tv.bounces = true
            self._cellReuseIdentifiers.forEach({ tv.register($0.value, forCellReuseIdentifier: $0.key) })
            self._headerReuseIdentifiers.forEach({ tv.register($0.value, forHeaderFooterViewReuseIdentifier: $0.key) })
        }
    }
    
    open func backAction() {
        self.endEditing(true)
        self.navigationController?.popViewController(animated: true)
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
        return UITableViewAutomaticDimension
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return 0
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return self._defaultHeaderHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return self._defaultFooterHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self._defaultRowHeight
    }
    
    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    
    open func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    open func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

open class UITableViewControllerExtended: UIViewController, InternalTableViewControllerProtocol, BackButtonProtocol {
        
    open lazy var delegate: UITableViewDelegate? = {
        guard var _delegate: UITableViewDelegate = self as UITableViewDelegate? else { return nil }
        return _delegate
    }()
    
    open lazy var datasource: UITableViewDataSource? = {
        guard var _datasource: UITableViewDataSource = self as UITableViewDataSource? else { return nil }
        return _datasource
    }()
    
    open lazy var _defaultTableView: UITableView = self.defaultTableView()
    
    open var _backBtn: UIBarButtonItem? = nil
    open var editingSection: Int? = nil
    
    internal var _viewIsBeingDisplayed: Bool = false
    open var viewIsBeingDisplayed: Bool { get { return self._viewIsBeingDisplayed }}
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.settingsProtocol?.secondaryInit?()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = self.navigationController?.viewControllers.count == 1 ? nil : self.backBtn
        
        if ( self._clearsSelectionOnViewWillAppear ) {
            self.tableView.indexPathsForSelectedRows?.forEach({self.tableView.deselectRow(at: $0, animated: false)})
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self._viewIsBeingDisplayed = true
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        self._viewIsBeingDisplayed = false
        if ( self.tableView.isEditing ) { self.tableView.setEditing(false, animated: false) }
        self.editingSection = nil
        super.viewWillDisappear(animated)
    }
}
