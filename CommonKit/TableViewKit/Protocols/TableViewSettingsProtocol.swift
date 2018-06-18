//
//  TableViewSettingsProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol TableViewSettingsProtocolBase {
    @objc optional var tableViewStyle: UITableViewStyle { get set }
    @objc optional var _tableView: UITableView { get set }
    @objc optional var cellReuseIdentifiers: [String: AnyClass] { get set }
    @objc optional var headerReuseIdentifiers: [String: AnyClass] { get set }
    @objc optional var defaultRowHeight: CGFloat { get set }
    @objc optional var defaultHeaderHeight: CGFloat { get set }
    @objc optional var defaultFooterHeight: CGFloat { get set }
    @objc optional var defaultBottomSpacing: CGFloat { get set }
    @objc optional var clearsSelectionOnViewWillAppear: Bool { get set }
    
    @objc optional func secondaryInit()
}

public protocol TableViewSettingsProtocol: TableViewSettingsProtocolBase {
    var tableView: UITableView { get }
    
    func cell(for reuseIdentifier: String) -> UITableViewCell
    func header(for reuseIdentifier: String) -> UITableViewHeaderFooterView
}

internal protocol InternalTableViewSettingsProtocol: TableViewSettingsProtocol {
    var settingsProtocol: TableViewSettingsProtocolBase? { get }
    var _tableViewStyle: UITableViewStyle { get }
    var _cellReuseIdentifiers: [String: AnyClass] { get }
    var _headerReuseIdentifiers: [String: AnyClass] { get }
    var _defaultRowHeight: CGFloat { get }
    var _defaultHeaderHeight: CGFloat { get }
    var _defaultFooterHeight: CGFloat { get }
    var _defaultBottomSpacing: CGFloat { get }
    var _clearsSelectionOnViewWillAppear: Bool { get }
    var _defaultTableView: UITableView { get set }
    
}

extension InternalTableViewSettingsProtocol {
    
    public var settingsProtocol: TableViewSettingsProtocolBase? {
        get { return self as TableViewSettingsProtocolBase? }
    }
    
    public var _tableViewStyle: UITableViewStyle {
        get { return self.settingsProtocol?.tableViewStyle ?? .grouped }
    }
    
    public var _cellReuseIdentifiers: [String: AnyClass] {
        get { return self.settingsProtocol?.cellReuseIdentifiers ?? [:] }
    }
    
    public var _headerReuseIdentifiers: [String: AnyClass] {
        get { return self.settingsProtocol?.headerReuseIdentifiers ?? [:] }
    }
    
    public var _defaultRowHeight: CGFloat {
        get { return self.settingsProtocol?.defaultRowHeight ?? 38.0 }
    }
    
    public var _defaultHeaderHeight: CGFloat {
        get { return self.settingsProtocol?.defaultHeaderHeight ?? 25.0 }
    }
    
    public var _defaultFooterHeight: CGFloat {
        get { return self.settingsProtocol?.defaultFooterHeight ?? 25.0 }
    }
    
    public var _defaultBottomSpacing: CGFloat {
        get { return self.settingsProtocol?.defaultBottomSpacing ?? 260.0 }
    }
    
    public var _clearsSelectionOnViewWillAppear: Bool {
        get { return self.settingsProtocol?.clearsSelectionOnViewWillAppear ?? true }
    }
    
    public var tableView: UITableView {
        get { return self.settingsProtocol?._tableView ?? self._defaultTableView }
    }
    
    public func cell(for reuseIdentifier: String) -> UITableViewCell {
        
        let _cell: UITableViewCell? = self.tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as UITableViewCell?
        assert(_cell != nil, "Cell reuse identifier " + reuseIdentifier + " is not registered with this controller.")
        return _cell!
    }
    
    public func header(for reuseIdentifier: String) -> UITableViewHeaderFooterView {
        let _header: UITableViewHeaderFooterView? = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as UITableViewHeaderFooterView?
        assert(_header != nil, "Header reuse identifier " + reuseIdentifier + " is not registered with this controller.")
        return _header!
    }
    
}
