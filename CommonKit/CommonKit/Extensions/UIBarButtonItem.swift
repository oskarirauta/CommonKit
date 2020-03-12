//
//  UIBarButtonItem.swift
//  CommonKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public extension UIBarButtonItem {
    
    /// SwifterSwift: Creates a flexible space UIBarButtonItem
    static var flexibleSpace: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }

    /// Add closure to UIBarButtonItem
    ///
    /// - Parameters:
    ///   - execute: closure.

    func add(_ execute: (() -> (Void))? ) {
        self.target = execute == nil ? nil : ClosureSleeve(for: self, execute!)
        self.action = execute == nil ? nil : #selector(ClosureSleeve.invoke)
    }
    
    /// SwifterSwift: Add Target to UIBarButtonItem
    ///
    /// - Parameters:
    ///   - target: target.
    ///   - action: selector to run when button is tapped.
    func addTargetForAction(_ target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }

    /// SwifterSwift: Creates a fixed space UIBarButtonItem with a specific width
    ///
    /// - Parameter width: Width of the UIBarButtonItem
    static func fixedSpace(width: CGFloat) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = width
        return barButtonItem
    }
    
}
