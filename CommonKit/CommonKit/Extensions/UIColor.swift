//
//  UIColor.swift
//  CommonKit
//
//  Created by Oskari Rauta on 25/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

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
    
    public func withAddedBlue(addedBlue: CGFloat) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red, green: green, blue: ( blue + addedBlue ) > 1.0 ? 1.0 : ( blue + addedBlue ), alpha: alpha)
    }
    
}
