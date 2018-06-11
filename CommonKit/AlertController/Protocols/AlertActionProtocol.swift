//
//  AlertActionProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public protocol AlertActionProperties {
    
    var buttonFont: [AlertActionStyle: UIFont] { get set }
    var buttonTextColor: [AlertActionStyle: UIColor] { get set }
    var buttonBgColor: [AlertActionStyle: UIColor] { get set }
    var buttonBgColorHighlighted: [AlertActionStyle: UIColor] { get set }
    
    var buttonCornerRadius: CGFloat? { get set }
    var buttonShadowColor: UIColor? { get set }
    var buttonHeight: CGFloat? { get set }
    var buttonMargin: CGFloat? { get set }
}

public protocol AlertActionProtocol: AlertActionProperties {
    
    func setButton(_ button: inout AlertButton, style: AlertActionStyle, controllerStyle: AlertControllerStyle)
}

extension AlertActionProtocol {
    
    public func setButton(_ button: inout AlertButton, style: AlertActionStyle, controllerStyle: AlertControllerStyle = .alert ) {
        
        button.layer.masksToBounds = false
        button.clipsToBounds = true
        
        button.titleLabel?.font = self.buttonFont[style] ?? DefaultAlertProperties.buttonFont[style]
        button.setTitleColor(self.buttonTextColor[style] ?? DefaultAlertProperties.buttonTextColor[style])
        button.tintColor = self.buttonTextColor[style] ?? DefaultAlertProperties.buttonTextColor[style]
        button.setBackgroundImage((self.buttonBgColor[style] ?? DefaultAlertProperties.buttonBgColor[style])?.image, for: UIControlState())
        button.setBackgroundImage((self.buttonBgColor[style] ?? DefaultAlertProperties.buttonBgColor[style])?.image, for: .selected)
        button.setBackgroundImage((self.buttonBgColorHighlighted[style] ?? self.buttonBgColorHighlighted[style])?.image, for: .highlighted)
        
        button.layer.cornerRadius = ( self.buttonCornerRadius ?? DefaultAlertProperties.buttonCornerRadius ) + ( controllerStyle == .actionSheet ? 2.0 : 0.0 )
        
        button.layer.shadowRadius = 2.0
        button.layer.shadowOffset = .zero
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = (self.buttonShadowColor ?? DefaultAlertProperties.buttonShadowColor).cgColor
        
        button.titleLabel?.allowsDefaultTighteningForTruncation = true
        button.titleLabel?.numberOfLines = 1
        button.titleLabel?.textAlignment = .center
        
    }
}
