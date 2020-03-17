//
//  UUID.swift
//  CommonKit
//
//  Created by Oskari Rauta on 12.03.20.
//  Copyright © 2020 Oskari Rauta. All rights reserved.
//

import Foundation

public extension UUID {
    
    static var new: String {
        get { return UUID().uuidString }
    }
    
}
