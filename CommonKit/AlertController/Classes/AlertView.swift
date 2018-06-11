//
//  AlertView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class AlertView: UIView, AlertActionProtocol {
    
    open var buttonFont: [AlertActionStyle : UIFont] = [:]
    open var buttonTextColor: [AlertActionStyle : UIColor] = [:]
    open var buttonBgColor: [AlertActionStyle : UIColor] = [:]
    open var buttonBgColorHighlighted: [AlertActionStyle : UIColor] = [:]
    
    open var buttonCornerRadius: CGFloat? = nil
    open var buttonShadowColor: UIColor? = nil
    open var buttonHeight: CGFloat? = nil
    open var buttonMargin: CGFloat? = nil
}

open class AlertImageView: UIImageView, AlertActionProtocol {
    
    open var buttonFont: [AlertActionStyle : UIFont] = [:]
    open var buttonTextColor: [AlertActionStyle : UIColor] = [:]
    open var buttonBgColor: [AlertActionStyle : UIColor] = [:]
    open var buttonBgColorHighlighted: [AlertActionStyle : UIColor] = [:]
    
    open var buttonCornerRadius: CGFloat? = nil
    open var buttonShadowColor: UIColor? = nil
    open var buttonHeight: CGFloat? = nil
    open var buttonMargin: CGFloat? = nil
}
