//
//  UITableViewExtended.swift
//  CommonKit
//
//  Created by Oskari Rauta on 12.03.20.
//  Copyright © 2020 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView.Style {
    
    var tableView: UITableView {
        switch self {
        case .grouped: return UITableView.Grouped
        case .insetGrouped: return UITableView.InsetGrouped
        case .plain: return UITableView.Plain
        @unknown default: return UITableView.Extended
        }
    }
}

public extension UITableView {
    
    static var Extended: UITableView {
        return UITableView(frame: .zero)
    }
    
    static var Grouped: UITableView {
        return UITableView(frame: .zero, style: .grouped)
    }

    static var InsetGrouped: UITableView {
        return UITableView(frame: .zero, style: .insetGrouped)
    }

    static var Plain: UITableView {
        return UITableView(frame: .zero, style: .plain)
    }
     
}
