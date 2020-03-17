//
//  TableViewConfig.swift
//  CommonKit
//
//  Created by Oskari Rauta on 15.03.20.
//  Copyright © 2020 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol TableViewConfig {
    
    @objc optional var _tableViewConfig: (UITableView) -> Void { get set }
    @objc optional var tableViewConfig: (UITableView) -> Void { get set }
}
