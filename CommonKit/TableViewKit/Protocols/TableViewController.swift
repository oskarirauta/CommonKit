//
//  TableViewController.swift
//  CommonKit
//
//  Created by Oskari Rauta on 15.03.20.
//  Copyright © 2020 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol TableViewControllerConfig {
    
    @objc optional var tableViewStyle: UITableView.Style { get set }
    @objc optional var tableViewOverride: UITableView { get set }
    @objc optional var cellReuseIdentifiers: [String: AnyClass] { get set }
    @objc optional var headerReuseIdentifiers: [String: AnyClass] { get set }
    @objc optional var rowHeight: CGFloat { get set }
    @objc optional var headerHeight: CGFloat { get set }
    @objc optional var footerHeight: CGFloat { get set }
    @objc optional var bottomSpacing: CGFloat { get set }
    @objc optional var clearsSelectionOnViewWillAppear: Bool { get set }
}

public protocol TableViewControllerProperties {
    
    var delegate: UITableViewDelegate? { get set }
    var dataSource: UITableViewDataSource? { get set }
    
    var tableView: UITableView! { get set }
    var style: UITableView.Style { get }
    var refreshControl: UIRefreshControl? { get set }
    
    var indexPathsForVisibleRows: [IndexPath]? { get }
    var visibleCells: [UITableViewCell] { get }
    
    var editingSection: Int? { get set }
    var isEditing: Bool { get set }
    var contentOffset: CGPoint { get set }
    var topOffset: CGPoint { get }
}

public protocol TableViewControllerMethods {
    
    init(style: UITableView.Style)
    init()
    
    func reloadData()
    func cell(for reuseIdentifier: String) -> UITableViewCell
    func header(for reuseIdentifier: String) -> UITableViewHeaderFooterView
    
    func numSections(_ tableView: UITableView?) -> Int
    func numRows(_ tableView: UITableView?, in section: Int) -> Int
    
    func hasIndexPath(_ tableView: UITableView?, at indexPath: IndexPath) -> Bool
    func indexPathIsVisible(_ tableView: UITableView?, at indexPath: IndexPath) -> Bool
    func indexPath(_ tableView: UITableView?, for: UITableViewCell) -> IndexPath?
    
    func setEditingSection(section: Int?)
    func setContentOffset(contentOffset: CGPoint, animated: Bool)
    func setEditing(_ editing: Bool, animated: Bool, section: Int?)
    func toggleEditing(for section: Int, animated: Bool)
    func endEditing(_ force: Bool, animated: Bool)
    func endEditing()
    
    func scrollToTop(animated: Bool)
    func scrollToBottom(section: Int, animated: Bool, at: UITableView.ScrollPosition)
    func scrollToFirstRow(animated: Bool)
    func scrollToRow(at indexPath: IndexPath, at: UITableView.ScrollPosition, animated: Bool)
}

public protocol TableViewController: UITableViewDelegate, UITableViewDataSource, TableViewControllerConfig, TableViewControllerProperties, TableViewControllerMethods { }
