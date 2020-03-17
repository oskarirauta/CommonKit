//
//  CustomBadgeConvertible.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public protocol CustomBadgeConvertible {
    
    var convertedBadge: BadgeItem? { get }
    func isEqual(to: BadgeItem?) -> Bool
}

public extension CustomBadgeConvertible {
    
    func isEqual(to: BadgeItem?) -> Bool {
        return ((( self.convertedBadge == nil ) && ( to == nil )) || (( self.convertedBadge != nil ) && ( to != nil ))) && ( self.convertedBadge?.text == to?.text ) && ( self.convertedBadge?.backgroundColor == to?.backgroundColor ) && ( self.convertedBadge?.foregroundColor == to?.foregroundColor )
    }
}

extension String: CustomBadgeConvertible {
    
    public var convertedBadge: BadgeItem? {
        return self.count == 0 ? nil : BadgeItem(text: self)
    }
}
