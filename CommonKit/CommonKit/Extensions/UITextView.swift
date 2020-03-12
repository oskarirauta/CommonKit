//
//  UITextView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 24/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Methods
public extension UITextView {

    /// SwifterSwift: Clear text.
    func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }

    /// SwifterSwift: Scroll to the bottom of text view
    func scrollToBottom() {
        // swiftlint:disable:next legacy_constructor
        let range = NSMakeRange((text as NSString).length - 1, 1)
        scrollRangeToVisible(range)
    }

    /// SwifterSwift: Scroll to the top of text view
    func scrollToTop() {
        // swiftlint:disable:next legacy_constructor
        let range = NSMakeRange(0, 1)
        scrollRangeToVisible(range)
    }

    /// SwifterSwift: Wrap to the content (Text / Attributed Text).
    func wrapToContent() {
        contentInset = .zero
        scrollIndicatorInsets = .zero
        contentOffset = .zero
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        sizeToFit()
    }

}

extension UITextView {

    private struct TV_AssociatedKeys {
        static var warningActive: Bool = false
    }
    
    internal var warningActive: Bool {
        get { return objc_getAssociatedObject(self, &TV_AssociatedKeys.warningActive) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &TV_AssociatedKeys.warningActive, newValue as Bool, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
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
