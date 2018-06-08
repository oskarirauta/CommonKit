//
//  CellConstraintProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

@objc public protocol CellConstraintBaseProtocol {
    func activateCellConstraints(_ key: String?)
    func deactivateCellConstraints( _ key: String?)
    @objc optional func updateCellConstraints()
    @objc optional func updateCellConstraint(_ key: String?)
}

public protocol CellConstraintProtocol: CellConstraintBaseProtocol {
    var cellConstraints: CellConstraints { get set }
}
