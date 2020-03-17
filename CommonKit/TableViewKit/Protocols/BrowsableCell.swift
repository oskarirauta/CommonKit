//
//  BrowsableCell.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol BrowsableCellProperties {

    var browsingDisabled: Bool { get set }
    var prevIndex: IndexPath? { get set }
    var nextIndex: IndexPath? { get set }
}

@objc public protocol BrowsableCellMethods {
    
    @objc func prevField(_ sender: Any)
    @objc func nextField(_ sender: Any)
}

public protocol BrowsableCell: BrowsableCellProperties, BrowsableCellMethods { }
