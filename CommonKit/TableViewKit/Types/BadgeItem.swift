//
//  BadgeItem.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public typealias BadgeCompatible = Optional<Any & CustomBadgeConvertible>

public struct BadgeItem: CustomBadgeConvertible {
    
    var text: String
    var backgroundColor: UIColor?
    var foregroundColor: UIColor?
    
    public var convertedBadge: BadgeItem? {
        return self
    }
    
    public init(text: String) {
        self.text = text
        self.backgroundColor = nil
        self.foregroundColor = nil
    }
    
    public init(text: String, backgroundColor: UIColor, foregroundColor: UIColor) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
}
