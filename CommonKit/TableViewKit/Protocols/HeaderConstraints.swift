//
//  HeaderConstraints.swift
//  CommonKit
//
//  Created by Oskari Rauta on 14/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

@objc public protocol HeaderConstraintsObjc {
    
    @objc optional func updateHeaderConstraints()
    @objc optional func updateHeaderConstraint(_ key: String?)
}

public protocol HeaderConstraintsProperties {
    
    var headerConstraints: [String: NSLayoutConstraint] { get set }
}

@objc public protocol HeaderConstraintsMethods {
    
    func activateHeaderConstraints(_ key: String?)
    func deactivateHeaderConstraints( _ key: String?)
}

public protocol HeaderConstraints: HeaderConstraintsObjc, HeaderConstraintsProperties, HeaderConstraintsMethods { }
