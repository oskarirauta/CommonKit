//
//  WarnSyntaxError.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11.06.19.
//  Copyright © 2019 Oskari Rauta. All rights reserved.
//

import Foundation

@objc protocol WarnSyntaxErrorObjc {
    
    @objc func warnSyntaxError(completion: (()->())?)
}

protocol WarnSyntaxErrorProperties {
    
    var warningActive: Bool { get set }
}

protocol WarnSyntaxErrorMethods { }

protocol WarnSyntaxError: WarnSyntaxErrorObjc, WarnSyntaxErrorProperties, WarnSyntaxErrorMethods { }

extension UITableViewCell: WarnSyntaxError {
        
    @objc open func warnSyntaxError(completion: (()->())? = nil) {

        guard !self.warningActive else {
            UIView.setAnimationsEnabled(false)
            self.backgroundView?.layer.removeAllAnimations()
            UIView.setAnimationsEnabled(true)
            return
        }
        
        self.warningActive = true
        self.backgroundView?.backgroundColor = UIColor.red.lighter(by: 0.7)
        
        UIView.animate(withDuration: TimeInterval(0.4), animations: {
            self.backgroundView?.backgroundColor = nil
        }, completion: {
            _ in
            completion?()
            self.warningActive = false
        })
    }
    
}
