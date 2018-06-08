//
//  AlertActionProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public protocol AlertActionProtocol {
    
    var buttonFont: [AlertActionStyle: UIFont] { get }
    var buttonTextColor: [AlertActionStyle: UIColor] { get }
    var buttonBgColor: [AlertActionStyle: UIColor] { get }
    var buttonBgColorHighlighted: [AlertActionStyle: UIColor] { get }
    var buttonCornerRadius: CGFloat { get }
    var buttonHeight: CGFloat { get }
    var buttonMargin: CGFloat { get }
    
    func setButton(_ button: inout AlertButton, style: AlertActionStyle, controllerStyle: AlertControllerStyle)
}

extension AlertActionProtocol {
    
    public func setButton(_ button: inout AlertButton, style: AlertActionStyle, controllerStyle: AlertControllerStyle = .alert ) {
        
        button.layer.masksToBounds = false
        button.clipsToBounds = true
        
        button.titleLabel?.font = self.buttonFont[style]
        button.setTitleColor(self.buttonTextColor[style])
        button.tintColor = self.buttonTextColor[style]
        button.setBackgroundImage(self.buttonBgColor[style]?.image, for: UIControlState())
        button.setBackgroundImage(self.buttonBgColor[style]?.image, for: .selected)
        button.setBackgroundImage(self.buttonBgColorHighlighted[style]?.image, for: .highlighted)
        
        button.layer.cornerRadius = self.buttonCornerRadius + ( controllerStyle == .actionSheet ? 2.0 : 0.0 )
        
        button.layer.shadowRadius = 2.0
        button.layer.shadowOffset = .zero
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        
        button.titleLabel?.allowsDefaultTighteningForTruncation = true
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.textAlignment = .center
        
    }
}

protocol DefaultAlertActionProtocol: AlertActionProtocol { }

extension DefaultAlertActionProtocol {
    
    public var buttonFont: [AlertActionStyle: UIFont] {
        get { return [
            .plain : UIFont(name: "HelveticaNeue", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .default : UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .cancel  : UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .destructive  : UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .accept  : UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16),
            .hazard  : UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16)
            ] }
    }
    
    public var buttonTextColor: [AlertActionStyle: UIColor] {
        get { return [
            .plain   : UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0),
            .default : UIColor.white,
            .cancel  : UIColor.white,
            .destructive  : UIColor.white,
            .accept  : UIColor.white,
            .hazard  : UIColor.white
            ] }
    }
    
    public var buttonBgColor: [AlertActionStyle: UIColor] {
        get { return [
            .plain   : UIColor.white,
            .default : UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha:1.0),
            .cancel  : UIColor(red: 127/255, green: 140/255, blue: 141/255, alpha:1.0),
            .destructive  : UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha:1.0),
            .accept  : UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1.0),
            .hazard  : UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
            ] }
    }
    
    public var buttonBgColorHighlighted: [AlertActionStyle: UIColor] {
        get { return [
            .plain   : UIColor.lightGray,
            .default : UIColor(red: 74/255, green: 163/255, blue: 223/255, alpha: 1.0),
            .cancel  : UIColor(red: 140/255, green: 152/255, blue: 153/255, alpha: 1.0),
            .destructive  : UIColor(red: 234/255, green: 97/255, blue: 83/255, alpha: 1.0),
            .accept  : UIColor(red: 86/255, green: 237/255, blue: 120/255, alpha: 1.0),
            .hazard  : UIColor(red: 255/255, green: 79/255, blue: 68/255, alpha: 1.0)
            ] }
    }
    
    public var buttonCornerRadius: CGFloat { get { return 4.0 }}
    public var buttonHeight: CGFloat { get { return  38.0 }}
    public var buttonMargin: CGFloat { get { return 8.0 }}
    
}

