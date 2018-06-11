//
//  DefaultAlertProperties.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public struct DefaultAlertProperties {
    
    public static var buttonFont: [AlertActionStyle: UIFont] {
        get { return [
            .plain : UIFont(name: "HelveticaNeue", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .default : UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .cancel  : UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .destructive  : UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .accept  : UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .hazard  : UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16)
            ] }
    }
    
    public static var buttonTextColor: [AlertActionStyle: UIColor] {
        get { return [
            .plain   : UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0),
            .default : UIColor.white,
            .cancel  : UIColor.white,
            .destructive  : UIColor.white,
            .accept  : UIColor.white,
            .hazard  : UIColor.white
            ] }
    }
    
    public static var buttonBgColor: [AlertActionStyle: UIColor] {
        get { return [
            .plain   : UIColor.white,
            .default : UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha:1.0),
            .cancel  : UIColor(red: 127/255, green: 140/255, blue: 141/255, alpha:1.0),
            .destructive  : UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha:1.0),
            .accept  : UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0),
            .hazard  : UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
            ] }
    }
    
    public static var buttonBgColorHighlighted: [AlertActionStyle: UIColor] {
        get { return [
            .plain   : UIColor.lightGray,
            .default : UIColor(red: 74/255, green: 163/255, blue: 223/255, alpha: 1.0),
            .cancel  : UIColor(red: 140/255, green: 152/255, blue: 153/255, alpha: 1.0),
            .destructive  : UIColor(red: 234/255, green: 97/255, blue: 83/255, alpha: 1.0),
            .accept  : UIColor(red: 86/255, green: 237/255, blue: 120/255, alpha: 1.0),
            .hazard  : UIColor(red: 255/255, green: 79/255, blue: 68/255, alpha: 1.0)
            ] }
    }
    
    public static var buttonCornerRadius: CGFloat { get { return 4.0 }}
    public static var buttonShadowColor: UIColor { get { return UIColor.black }}

    public static var buttonHeight: CGFloat { get { return 38.0 }}
    
    public static var buttonMargin: CGFloat { get { return 8.0 }}
    
    public static var fullScreen: Bool { get { return false }}
    public static var actionSheetBounceHeight: CGFloat { get { return 20.0 }}
    
    public static var alertViewWidth: CGFloat { get { return 270.0 }}
    public static var alertViewPadding: CGFloat { get { return 12.0 }}
    public static var innerContentWidth: CGFloat { get { return 240.0 }}
    
    public static var overlayColor: UIColor { get { return UIColor(red:0, green:0, blue:0, alpha:0.79) }}
    public static var contentViewBgColor: UIColor { get { return UIColor.white }}
    
    public static var contentViewDefaultHeight: CGFloat { get { return 150.0 }}
}
