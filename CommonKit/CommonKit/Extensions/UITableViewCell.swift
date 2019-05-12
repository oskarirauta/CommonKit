//
//  UITableViewCell.swift
//  CommonKit
//
//  Created by Oskari Rauta on 24/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {

    public func warnSyntaxError(completion: (()->())? = nil) {
        
        guard !self.warningActive else {
            completion?()
            return
        }
        
        self.warningActive = true
        let origColor: CGColor? = self.layer.backgroundColor
        self.layer.backgroundColor = UIColor.red.lighter(by: 0.7).cgColor
        
        UIView.animate(withDuration: TimeInterval(0.68), animations: {
            self.layer.backgroundColor = origColor
        }, completion: {
            _ in
            completion?()
            self.warningActive = false
        })
    }

}
