//
//  UIResponder.swift
//  CommonKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

fileprivate var firstResponderRef: UIResponder? = nil

extension UIResponder {
    
    @objc private func setFirstResponderRef() {
        firstResponderRef = self
    }

    public static var firstResponder: UIResponder? {
        get {
            firstResponderRef = nil
            // The trick here is, that the selector will be invoked on the first responder
            UIApplication.shared.sendAction(#selector(setFirstResponderRef), to: nil, from: nil, for: nil)
            return firstResponderRef
        }
    }

}
