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
        return UIColor.darkText
        //return UIColor(red: 154.00/255.00, green: 154.00/255.00, blue: 154.00/255.00, alpha: 1.0)
    }
    
    class var badgeForegroundColor: UIColor {
        //return UIColor.white
        
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                // Return one of two colors depending on light or dark mode
                return traits.userInterfaceStyle == .dark ? UIColor.white.darker(by: 0.04).withAlphaComponent(0.9) : UIColor.white.withAlphaComponent(0.9)
            }
        } else {
            // Same old color used for iOS 12 and earlier
            return .lightText
        }
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
        return UIColor.darkText.withAlphaComponent(0.85)
    }
    
    class var cellBackgroundColor: UIColor {
        return UIColor.secondarySystemGroupedBackground
    }
    
    class var defaultTitleColor: UIColor {
            return UIColor.label
    }
    
    class var disabledColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                // Return one of two colors depending on light or dark mode
                return traits.userInterfaceStyle == .dark ? .lightText : UIColor.darkGray.lighter(by: 0.1).withAlphaComponent(0.85)
            }
        } else {
            // Same old color used for iOS 12 and earlier
            return .lightText
        }
    }
    
    class var tipColor: UIColor {
        return UIColor.darkText
    }
    
    class var toolbarColor: UIColor {
            return UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    }
    
    class var keyboardBackgroundColor: UIColor {
            return .quaternarySystemFill
    }
    
    class var tableViewSeparatorColor: UIColor {
            return UIColor.separator
            //return UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1.0) }
    }
    
    var image: UIImage? {
        get {
            UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
            guard let contextRef: CGContext = UIGraphicsGetCurrentContext() else { return nil }
            contextRef.setFillColor(self.cgColor)
            contextRef.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            guard let img: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
                UIGraphicsEndImageContext()
                return nil
            }
            UIGraphicsEndImageContext()
            return img
        }
    }
    
    /// SwifterSwift: Hexadecimal value string (read-only).
    var hexString: String {
        get {
            let components: [Int] = {
                let comps = cgColor.components!
                let components = comps.count == 4 ? comps : [comps[0], comps[0], comps[0], comps[1]]
                return components.map { Int($0 * 255.0) }
            }()
            return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
        }
    }
    
    /// SwifterSwift: Short hexadecimal value string (read-only, if applicable).
    var shortHexString: String? {
        get {
            let string = hexString.replacingOccurrences(of: "#", with: "")
            let chrs = Array(string)
            guard chrs[0] == chrs[1], chrs[2] == chrs[3], chrs[4] == chrs[5] else { return nil }
            return "#\(chrs[0])\(chrs[2])\(chrs[4])"
        }
    }
    
    /// SwifterSwift: Short hexadecimal value string, or full hexadecimal string if not possible (read-only).
    var shortHexOrHexString: String {
        get {
            return self.shortHexString ?? self.hexString
        }
    }
    
    /// SwifterSwift: Alpha of Color (read-only).
    var alpha: CGFloat {
        return cgColor.alpha
    }
    
    convenience init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
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
    convenience init?(hex: Int, transparency: CGFloat = 1) {
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
    
    convenience init?(hexString: String, transparency: CGFloat = 1) {
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
    
    func withAddedRed(_ addedRed: CGFloat) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: min( red + addedRed, 1.0 ), green: green, blue: blue, alpha: alpha)
    }

    func withAddedGreen(_ addedGreen: CGFloat) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red, green: min( green + addedGreen, 1.0 ), blue: blue, alpha: alpha)
    }

    func withAddedBlue(_ addedBlue: CGFloat) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red, green: green, blue: min( blue + addedBlue, 1.0 ), alpha: alpha)
    }
    
    func lighter(by percentage: CGFloat) -> UIColor {
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: min(red + percentage, 1.0),
                     green: min(green + percentage, 1.0),
                     blue: min(blue + percentage, 1.0),
                     alpha: alpha)
    }

    func darker(by percentage: CGFloat) -> UIColor {
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: max(red - percentage, 0.0),
                       green: max(green - percentage, 0.0),
                       blue: max(blue - percentage, 0.0),
                       alpha: alpha)
    }

    func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            if b < 1.0 {
                /**
                 Below is the new part, which makes the code work with black as well as colors
                 */
                return UIColor(
                    hue: h,
                    saturation: s,
                    brightness: b == 0.0 ? max(min(b + percentage/100, 1.0), 0.0) : max(min(b + (percentage/100.0)*b, 1.0), 0,0),
                    alpha: a)
            } else {
                return UIColor(hue: h, saturation: min(max(s - (percentage/100.0)*s, 0.0), 1.0), brightness: b, alpha: a)
            }
        }
        return self
    }
    
}

