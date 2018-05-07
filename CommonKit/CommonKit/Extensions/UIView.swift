//
//  UIView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension UIView {
    
    public func removeAllSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
}
