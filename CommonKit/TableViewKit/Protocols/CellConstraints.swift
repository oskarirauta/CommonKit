//
//  CellConstraints.swift
//  CommonKit
//
//  Created by Oskari Rauta on 15.03.20.
//  Copyright © 2020 Oskari Rauta. All rights reserved.
//

import Foundation

@objc public protocol CellConstraintsObjc {
    
    @objc optional func updateCellConstraints()
    @objc optional func updateCellConstraint(_ key: String?)
}

public protocol CellConstraintsProperties {
    
    var cellConstraints: [String: NSLayoutConstraint] { get set }
}

public protocol CellConstraintsMethods {
    
    func activateCellConstraints(_ key: String?)
    func deactivateCellConstraints( _ key: String?)
}

public protocol CellConstraints: CellConstraintsObjc, CellConstraintsProperties, CellConstraintsMethods { }
