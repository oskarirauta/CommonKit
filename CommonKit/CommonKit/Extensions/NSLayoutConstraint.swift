//
//  NSLayoutConstraint.swift
//  CommonKit
//
//  Created by Oskari Rauta on 25/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutXAxisAnchor {
    
    public func constraint(equalTo anchor: NSLayoutXAxisAnchor, multiplier m: CGFloat, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return self.constraint(equalTo: anchor, constant: c).constraint(multiplier: m)
    }

    public func constraint(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, multiplier m: CGFloat, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return self.constraint(greaterThanOrEqualTo: anchor, constant: c).constraint(multiplier: m)
    }
    
    public func constraint(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor, multiplier m: CGFloat, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return self.constraint(lessThanOrEqualTo: anchor, constant: c).constraint(multiplier: m)
    }
    
}

extension NSLayoutYAxisAnchor {
    
    public func constraint(equalTo anchor: NSLayoutYAxisAnchor, multiplier m: CGFloat, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return self.constraint(equalTo: anchor, constant: c).constraint(multiplier: m)
    }
    
    public func constraint(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, multiplier m: CGFloat, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return self.constraint(greaterThanOrEqualTo: anchor, constant: c).constraint(multiplier: m)
    }
    
    public func constraint(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, multiplier m: CGFloat, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return self.constraint(lessThanOrEqualTo: anchor, constant: c).constraint(multiplier: m)
    }
}

private extension NSLayoutConstraint {
    
    func constraint(multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstItem!,
                                  attribute: firstAttribute,
                                  relatedBy: relation,
                                  toItem: secondItem,
                                  attribute: secondAttribute,
                                  multiplier: multiplier,
                                  constant: constant)
    }
    
}

public protocol NSLayoutConstraintPriorityProtocol {
    func withPriority(_ priority: Int) -> NSLayoutConstraint
    func withPriority(_ priority: Float) -> NSLayoutConstraint
}

extension NSLayoutConstraint: NSLayoutConstraintPriorityProtocol {
    
    public func withPriority(_ priority: Int) -> NSLayoutConstraint {
        let layoutConstraint: NSLayoutConstraint = self
        layoutConstraint.priority = UILayoutPriority(rawValue: Float(priority))
        return layoutConstraint
    }
    
    public func withPriority(_ priority: Float) -> NSLayoutConstraint {
        let layoutConstraint: NSLayoutConstraint = self
        layoutConstraint.priority = UILayoutPriority(rawValue: priority)
        return layoutConstraint
    }
}

public protocol NSLayoutConstraintArrayProtocol {
    func enableAll()
    func disableAll()
    mutating func disableAndRemoveAll()
}

extension Array: NSLayoutConstraintArrayProtocol where Element == NSLayoutConstraint {

    public func enableAll() {
        self.forEach { $0.isActive = true }
    }
    
    public func disableAll() {
        self.forEach { $0.isActive = false }
    }
    
    public mutating func disableAndRemoveAll() {
        self.forEach { $0.isActive = false }
        self.removeAll()
    }
}

extension Dictionary:NSLayoutConstraintArrayProtocol where Key == String, Value == NSLayoutConstraint {
    
    public func enableAll() {
        self.forEach { $0.value.isActive = true }
    }
    
    public func disableAll() {
        self.forEach { $0.value.isActive = false }
    }
    
    public mutating func disableAndRemoveAll(_ keepRowHeight: Bool = true) {
        ( keepRowHeight ? self.filter { $0.key != "rowHeight"  } : self ).forEach {
            $0.value.isActive = true
        }
        guard let rowHeightConstraint: NSLayoutConstraint = self["rowHeight"] else {
            self.removeAll()
            return
        }
        self.removeAll()
        self["rowHeight"] = rowHeightConstraint
    }
    
    public mutating func disableAndRemoveAll() {
        self.disableAndRemoveAll(true)
    }
    
}
