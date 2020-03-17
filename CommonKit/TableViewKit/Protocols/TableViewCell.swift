//
//  TableViewCell.swift
//  CommonKit
//
//  Created by Oskari Rauta on 15.03.20.
//  Copyright © 2020 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol TableViewCellConfig {
    
    @objc optional var _TableViewCellConfig: (UITableViewCell) -> Void { get set }
    @objc optional var TableViewCellConfig: (UITableViewCell) -> Void { get set }
}

public protocol TableViewCellProperties {
    
    var editingSection: Int? { get set }
}

public protocol TableViewCellMethods { }

public protocol TableViewCell: TableViewCellConfig, CellConstraints, SelectableCell, TableViewCellProperties, TableViewCellMethods {
    
}
