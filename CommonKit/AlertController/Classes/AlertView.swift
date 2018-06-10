//
//  AlertView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class AlertView: UIView, DefaultAlertActionProtocol {
    
    public lazy var defaults: DefaultAlertProperties = DefaultAlertProperties()
    
    public lazy var buttonFont: [AlertActionStyle : UIFont] = self.defaults.buttonFont
    public lazy var buttonTextColor: [AlertActionStyle : UIColor] = self.defaults.buttonTextColor
    public lazy var buttonBgColor: [AlertActionStyle : UIColor] = self.defaults.buttonBgColor
    public lazy var buttonBgColorHighlighted: [AlertActionStyle : UIColor] = self.defaults.buttonBgColorHighlighted
    public lazy var buttonCornerRadius: CGFloat = self.defaults.buttonCornerRadius
    public lazy var buttonHeight: CGFloat = self.defaults.buttonHeight
    public lazy var buttonMargin: CGFloat = self.defaults.buttonMargin
}
