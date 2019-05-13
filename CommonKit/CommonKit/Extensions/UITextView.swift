//
//  UITextView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 24/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {

    private struct TV_AssociatedKeys {
        static var warningActive: Bool = false
    }
    
    internal var warningActive: Bool {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys.warningActive) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys.warningActive, newValue as Bool, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    public func warnSyntaxError(completion: (()->())? = nil) {
        
        guard !self.warningActive else {
            completion?()
            return
        }
        
        self.warningActive = true
        let origColor: CGColor? = self.layer.backgroundColor
        self.layer.backgroundColor = UIColor.red.lighter(by: 0.7).cgColor
        
        UIView.animate(withDuration: TimeInterval(0.48), animations: {
            self.layer.backgroundColor = origColor
        }, completion: {
            _ in
            completion?()
            self.warningActive = false
        })
    }
}
