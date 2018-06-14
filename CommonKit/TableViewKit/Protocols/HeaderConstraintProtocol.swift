//
//  HeaderConstraintProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 14/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

@objc public protocol HeaderConstraintBaseProtocol {
    func activateHeaderConstraints(_ key: String?)
    func deactivateHeaderConstraints( _ key: String?)
    @objc optional func updateHeaderConstraints()
    @objc optional func updateHeaderConstraint(_ key: String?)
}

public protocol HeaderConstraintProtocol: HeaderConstraintBaseProtocol {
    var headerConstraints: HeaderConstraints { get set }
}
