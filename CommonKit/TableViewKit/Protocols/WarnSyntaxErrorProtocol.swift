//
//  WarnSyntaxErrorProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11.06.19.
//  Copyright © 2019 Oskari Rauta. All rights reserved.
//

import Foundation

@objc protocol WarnSyntaxErrorProtocolBase {
    
    var warningActive: Bool { get set }

    func warnSyntaxError(completion: (()->())?)
    
}

protocol WarnSyntaxErrorProtocol: WarnSyntaxErrorProtocolBase { }

extension UITableViewCellExtended: WarnSyntaxErrorProtocol {
        
    open func warnSyntaxError(completion: (()->())? = nil) {
        
        if self.warningActive {
            UIView.setAnimationsEnabled(false)
            self.backgroundView?.layer.removeAllAnimations()
            UIView.setAnimationsEnabled(true)
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
