//
//  UIColor.swift
//  CommonKit
//
//  Created by Oskari Rauta on 25/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    class var headerFooterColor: UIColor {
        return UIColor(red: 154.00/255.00, green: 154.00/255.00, blue: 154.00/255.00, alpha: 1.0)
    }
    
    class var badgeForegroundColor: UIColor {
        return UIColor.white
    }
    
    class var blueBadgeBackgroundColor: UIColor {
        return UIColor(red: 114.00/255.00, green: 117.00/255.00, blue: 188.00/255.00, alpha: 1.0)
    }
    
    class var badgeBackgroundColor: UIColor {
        return UIColor(red: 124.00/255.00, green: 127.00/255.00, blue: 168.00/255.00, alpha: 1.0)
    }
    
    class var badge2BackgroundColor: UIColor {
        return UIColor(red: 142.0/255, green: 156.0/255, blue: 183.0/255, alpha: 1.0)
    }
    
    class var badgeCompleteColor: UIColor {
        return UIColor(red: 142.00/255.00, green: 156.00/255.00, blue: 183.00/255.00, alpha: 1.0)
    }
    
    class var badgeIncompleteColor: UIColor {
        return UIColor(red: 238.00/255.00, green: 126.00/255.00, blue: 143.00/255.00, alpha: 1.0)
    }
    
    class var buttonForegroundColor: UIColor {
        return UIColor(red: 0.00/255.00, green: 122.0/255.00, blue: 255.00/255.00, alpha: 1.0)
    }
    
    class var button2ForegroundColor: UIColor {
        return UIColor(red: 0.00/255.00, green: 122.0/255.00, blue: 216.00/255.00, alpha: 1.0)
    }
    
    class var button3ForegroundColor: UIColor {
        return UIColor(red: 85.00/255.00, green: 145.0/255.00, blue: 240.00/255.00, alpha: 1.0)
    }
    
    class var defaultShadowColor: UIColor {
        return UIColor(red: 128.00/255.00, green: 128.00/255.00, blue: 128.00/255.00, alpha: 1.0)
    }
    
    class var timeTextColor: UIColor {
        return UIColor.darkGray.withAlphaComponent(0.85)
    }
    
    class var cellBackgroundColor: UIColor {
        return UIColor.white
    }
    
    class var defaultTitleColor: UIColor {
        return UIColor(red: 28.00/255.00, green: 38.00/255.00, blue: 43.00/255.00, alpha: 0.90)
    }
    
    class var tipColor: UIColor {
        return UIColor.darkGray
    }
    
    class var toolbarColor: UIColor {
        get { return UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0) }
    }
    
    class var keyboardBackgroundColor: UIColor {
        get { return UIColor(red: 210.0/255.0, green: 213.0/255.0, blue: 219.0/255.0, alpha: 1.0) }
    }
    
    public convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }
        
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: trans)
    }
    
    /// SwifterSwift: Create Color from hexadecimal value with optional transparency.
    ///
    /// - Parameters:
    ///   - hex: hex Int (example: 0xDECEB5).
    ///   - transparency: optional transparency value (default is 1).
    public convenience init?(hex: Int, transparency: CGFloat = 1) {
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
    
    public convenience init?(hexString: String, transparency: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }
        
        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }
        
        guard let hexValue = Int(string, radix: 16) else { return nil }
        
        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        self.init(red: red, green: green, blue: blue, transparency: transparency < 0 ? 0 : ( transparency > 1 ? 1 : transparency))
    }
    
    public func withAddedRed(_ addedRed: CGFloat) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: ( red + addedRed ) > 1.0 ? 1.0 : ( red + addedRed ), green: green, blue: blue, alpha: alpha)
    }

    public func withAddedGreen(_ addedGreen: CGFloat) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red, green: ( green + addedGreen ) > 1.0 ? 1.0 : ( green + addedGreen ), blue: blue, alpha: alpha)
    }

    public func withAddedBlue(_ addedBlue: CGFloat) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red, green: green, blue: ( blue + addedBlue ) > 1.0 ? 1.0 : ( blue + addedBlue ), alpha: alpha)
    }
    
    public func lighter(_ by: CGFloat) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(
            red: ( red + by ) > 1.0 ? 1.0 : ( red + by ),
            green: ( green + by ) > 1.0 ? 1.0 : ( green + by ),
            blue: ( blue + by ) > 1.0 ? 1.0 : ( blue + by ),
            alpha: alpha
        )
    }

    public func darker(_ by: CGFloat) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(
            red: ( red - by ) < 0.0 ? 0.0 : ( red - by ),
            green: ( green - by ) < 0.0 ? 0.0 : ( green - by ),
            blue: ( blue - by ) < 0.0 ? 0.0 : ( blue - by ),
            alpha: alpha
        )
    }

}
