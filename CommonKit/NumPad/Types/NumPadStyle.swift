//
//  NumPadStyle.swift
//  NumPad
//
//  Created by Oskari Rauta on 05/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public struct NumPadStyle {
    
    public var overlayColor: UIColor
    public var backgroundColor: UIColor
    public var backgroundColorHighlighted: UIColor
    public var shadowColor: UIColor
    public var foregroundColor: UIColor
    public var foregroundColorHighlighted: UIColor
    public var font: UIFont
    public var phoneFont: UIFont
    public var phoneCharFont: UIFont
    public var backspaceColor: UIColor
    
    public static var `default`: NumPadStyle = NumPadStyle(
        overlayColor: UIColor.keyboardBackgroundColor,
        backgroundColor: UIColor.secondarySystemFill,
        backgroundColorHighlighted: UIColor.quaternarySystemFill,
        shadowColor: UIColor.secondaryLabel,
        foregroundColor: UIColor.label,
        foregroundColorHighlighted: UIColor.tertiaryLabel,
        font: UIFont.systemFont(ofSize: 25.0, weight: .semibold),
        phoneFont: UIFont.systemFont(ofSize: 20.0, weight: .regular),
        phoneCharFont: UIFont.systemFont(ofSize: 8.5, weight: .semibold),
        backspaceColor: UIColor.secondaryLabel
    )

}
