//
//  UIRectCorner.swift
//  CommonKit
//
//  Created by Oskari Rauta on 25/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit
import Foundation

public protocol UIRectCornerMaskProtocol {
    var cornerMask: CACornerMask { get set }
}

extension UIRectCorner: UIRectCornerMaskProtocol {
    
    public var cornerMask: CACornerMask {
        get {
            var ret: CACornerMask = []
            
            if self.contains(.allCorners) { ret = [ .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner ]
            } else {
                if self.contains(.bottomLeft) { ret.insert(.layerMinXMaxYCorner) }
                if self.contains(.bottomRight) { ret.insert(.layerMaxXMaxYCorner) }
                if self.contains(.topLeft) { ret.insert(.layerMinXMinYCorner) }
                if self.contains(.topRight) { ret.insert(.layerMaxXMinYCorner) }
            }
            return ret
        }
        set {
            var newSet: UIRectCorner = UIRectCorner()
            if (( newValue.contains(.layerMinXMinYCorner)) && ( newValue.contains(.layerMinXMaxYCorner)) && ( newValue.contains(.layerMaxXMinYCorner)) && ( newValue.contains(.layerMaxXMaxYCorner))) {
                newSet = .allCorners
            } else {
                if ( newValue.contains(.layerMinXMinYCorner)) { newSet.insert(.topLeft) }
                if ( newValue.contains(.layerMaxXMinYCorner)) { newSet.insert(.topRight) }
                if ( newValue.contains(.layerMinXMaxYCorner)) { newSet.insert(.bottomLeft) }
                if ( newValue.contains(.layerMaxXMaxYCorner)) { newSet.insert(.bottomRight) }
            }
            self = newSet
        }
    }
    
}
