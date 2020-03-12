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
        get {
            return colorScheme(default: .darkText)
        }
    }
    
    class var badgeForegroundColor: UIColor {
        get {
            return colorScheme( default: .lightText,
                                dark: UIColor.white.darker(by: 0.02).withAlphaComponent(0.9),
                                light: UIColor.white.withAlphaComponent(0.9))
        }
    }
    
    class var blueBadgeBackgroundColor: UIColor {
        get {
            return colorScheme(default: UIColor(red: 114.00/255.00, green: 117.00/255.00, blue: 188.00/255.00, alpha: 1.0))
        }
    }
    
    class var badgeBackgroundColor: UIColor {
        get {
            return colorScheme(default: UIColor(red: 124.00/255.00, green: 127.00/255.00, blue: 168.00/255.00, alpha: 1.0))
        }
    }
    
    class var badge2BackgroundColor: UIColor {
        get {
            return colorScheme(default: UIColor(red: 142.0/255, green: 156.0/255, blue: 183.0/255, alpha: 1.0))
        }
    }
    
    class var badgeCompleteColor: UIColor {
        get {
            return colorScheme( default: UIColor(red: 142.00/255.00, green: 156.00/255.00, blue: 183.00/255.00, alpha: 1.0),
                                dark: UIColor(red: 142.00/255.00, green: 156.00/255.00, blue: 183.00/255.00, alpha: 1.0).darker(by: 0.3),
                                light: UIColor(red: 142.00/255.00, green: 156.00/255.00, blue: 183.00/255.00, alpha: 1.0))
        }
    }
    
    class var badgeIncompleteColor: UIColor {
        get {
            return colorScheme( default: UIColor(red: 238.00/255.00, green: 126.00/255.00, blue: 143.00/255.00, alpha: 1.0),
                dark: UIColor(red: 238.00/255.00, green: 126.00/255.00, blue: 143.00/255.00, alpha: 1.0).darker(by: 0.15),
                light: UIColor(red: 238.00/255.00, green: 126.00/255.00, blue: 143.00/255.00, alpha: 1.0))
        }
    }
    
    class var buttonForegroundColor: UIColor {
        get {
            return colorScheme(default: UIColor(red: 0.00/255.00, green: 122.0/255.00, blue: 255.00/255.00, alpha: 1.0))
        }
    }
    
    class var button2ForegroundColor: UIColor {
        get {
            return colorScheme(default: UIColor(red: 0.00/255.00, green: 122.0/255.00, blue: 216.00/255.00, alpha: 1.0))
        }
    }
    
    class var button3ForegroundColor: UIColor {
        get {
            return colorScheme(default: UIColor(red: 85.00/255.00, green: 145.0/255.00, blue: 240.00/255.00, alpha: 1.0))
        }
    }
    
    class var defaultShadowColor: UIColor {
        get {
            return colorScheme(default: UIColor(red: 128.00/255.00, green: 128.00/255.00, blue: 128.00/255.00, alpha: 1.0))
        }
    }
    
    class var timeTextColor: UIColor {
        get {
            return colorScheme(default: UIColor.darkText.withAlphaComponent(0.85))
        }
    }
    
    class var cellBackgroundColor: UIColor {
        get {
            return colorScheme(default: UIColor.secondarySystemGroupedBackground)
        }
    }
    
    class var defaultTitleColor: UIColor {
        get {
            return colorScheme(default: .label)
        }
    }
    
    class var disabledColor: UIColor {
        get {
            return colorScheme(default: .lightText, dark: .lightText, light: UIColor.darkGray.lighter(by: 0.1).withAlphaComponent(0.85))
        }
    }

    class var placeholderColor: UIColor {
        get {
            return colorScheme(default: .lightText, dark: .darkGray, light: .lightGray)
        }
    }

    class var tipColor: UIColor {
        get {
            return colorScheme(default: .darkText)
        }
    }
    
    class var toolbarColor: UIColor {
        get {
            return colorScheme(default: UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0))
        }
    }
    
    class var keyboardBackgroundColor: UIColor {
        get {
            return colorScheme(default: .quaternarySystemFill)
        }
    }
    
    class var tableViewSeparatorColor: UIColor {
        get {
            return colorScheme(default: .separator)
        }
    }
    
    class func colorScheme(default: UIColor, dark: UIColor? = nil, light: UIColor? = nil) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traits) -> UIColor in
                switch traits.userInterfaceStyle {
                case .dark: return dark ?? `default`
                case .light: return light ?? `default`
                case .unspecified: return `default`
                @unknown default: return `default`
                }
            }
        } else { return `default` }
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
        get {
            return cgColor.alpha
        }
    }
    
    var rgbComponents: (red: Int, green: Int, blue: Int) {
        get {
            var components: [CGFloat] {
                let comps = cgColor.components!
                if comps.count == 4 { return comps }
                return [comps[0], comps[0], comps[0], comps[1]]
            }
            let red = components[0]
            let green = components[1]
            let blue = components[2]
            return (red: Int(red * 255.0), green: Int(green * 255.0), blue: Int(blue * 255.0))
        }
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

    convenience init(default: UIColor, light: UIColor? = nil, dark: UIColor? = nil) {
        #if os(watchOS)
        return `default`
        #else
        if #available(iOS 13.0, *) {
            self.init(dynamicProvider: { $0.userInterfaceStyle == .dark ? ( dark ?? `default` ) : ( $0.userInterfaceStyle == .light ? ( light ?? `default` ) : `default` ) })
        } else {
            let rgb = `default`.rgbComponents
            self.init(red: CGFloat(rgb.red), green: CGFloat(rgb.green), blue: CGFloat(rgb.blue), alpha: `default`.alpha)
        }
        #endif
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

    func adjustBrightness(by percentage: CGFloat) -> UIColor {
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
    
    /// SwifterSwift: Random color.
    static var random: UIColor {
        let red = Int.random(in: 0...255)
        let green = Int.random(in: 0...255)
        let blue = Int.random(in: 0...255)
        return UIColor(red: red, green: green, blue: blue)!
    }
    
}

