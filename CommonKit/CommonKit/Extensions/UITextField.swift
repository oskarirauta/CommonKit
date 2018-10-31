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
    
    public func warnSyntaxError() {
        let origColor: CGColor? = self.layer.backgroundColor
        self.layer.backgroundColor = UIColor.red.lighter(by: 0.7).cgColor
        
        UIView.animate(withDuration: TimeInterval(0.68), animations: {
            self.layer.backgroundColor = origColor
        })
    }
}
