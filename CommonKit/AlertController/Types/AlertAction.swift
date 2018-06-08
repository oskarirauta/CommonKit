//
//  AlertAction.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

let AlertActionEnabledDidChangeNotification = "DOAlertActionEnabledDidChangeNotification"

open class AlertAction: NSObject, NSCopying {
    
    open var title: String
    open var style: AlertActionStyle
    open var handler: ((AlertAction) -> ())?
    
    @objc open var enabled: Bool {
        didSet {
            guard oldValue != self.enabled else { return }
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: AlertActionEnabledDidChangeNotification), object: nil)
        }
    }
    
    required public init(title: String, style: AlertActionStyle, handler: ((AlertAction) -> ())?) {
        self.title = title
        self.style = style
        self.handler = handler
        self.enabled = true
    }
    
    open func copy(with zone: NSZone?) -> Any {
        let copy = type(of: self).init(title: title, style: style, handler: handler)
        copy.enabled = self.enabled
        return copy
    }
}
