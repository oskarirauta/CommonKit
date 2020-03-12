//
//  UIDatePicker.swift
//  CommonKit
//
//  Created by Oskari Rauta on 12.03.20.
//

import UIKit

// MARK: - Properties
public extension UIDatePicker {

    /// SwifterSwift: Text color of UIDatePicker.
    var textColor: UIColor? {
        set {
            setValue(newValue, forKeyPath: "textColor")
        }
        get {
            return value(forKeyPath: "textColor") as? UIColor
        }
    }

}
