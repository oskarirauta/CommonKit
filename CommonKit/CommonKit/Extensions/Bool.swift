//
//  Bool.swift
//  CommonKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension Bool {

    public var int: Int {
        get { return self ? 1 : 0 }
        set { self = newValue == 0 ? false : true }
    }
}
