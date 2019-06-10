//
//  UITextField.swift
//  CommonKit
//
//  Created by Oskari Rauta on 24/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    private struct TF_AssociatedKeys {
        static var warningActive: Bool = false
    }

    internal var warningActive: Bool {
        get { return objc_getAssociatedObject(self, &TF_AssociatedKeys.warningActive) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &TF_AssociatedKeys.warningActive, newValue as Bool, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    public var cursorPosition: Int? {
        get {
            guard let selectedRange: UITextRange = self.selectedTextRange else { return nil }
            return self.positionToInt(from: selectedRange.start)
        }
        set {
            guard
                newValue != nil,
                let pos: UITextPosition = self.position(from: self.beginningOfDocument, offset: newValue!),
                let range: UITextRange = self.textRange(from: pos, to: pos)
                else { return }
            self.selectedTextRange = range
        }
    }

    public func positionToInt(from position: UITextPosition) -> Int {
        return self.offset(from: self.beginningOfDocument, to: position)
    }
    
    open func warnSyntaxError(completion: (()->())? = nil) {
        
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
