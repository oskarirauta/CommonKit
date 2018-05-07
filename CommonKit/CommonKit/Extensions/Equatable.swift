//
//  Equatable.swift
//  CommonKit
//
//  Created by Oskari Rauta on 25/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension Equatable {
    
    public func isAny(of candidates: Self...) -> Bool {
        return candidates.contains(self)
    }
}
