//
//  UITextField.swift
//  CommonKit
//
//  Created by Oskari Rauta on 24/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Enums
public extension UITextField {

    /// SwifterSwift: UITextField text type.
    ///
    /// - emailAddress: UITextField is used to enter email addresses.
    /// - password: UITextField is used to enter passwords.
    /// - generic: UITextField is used to enter generic text.
    enum TextType {
        /// SwifterSwift: UITextField is used to enter email addresses.
        case emailAddress

        /// SwifterSwift: UITextField is used to enter passwords.
        case password

        /// SwifterSwift: UITextField is used to enter generic text.
        case generic
    }

}

// MARK: - Properties
public extension UITextField {

    /// SwifterSwift: Set textField for common text types.
    var textType: TextType {
        get {
            if keyboardType == .emailAddress {
                return .emailAddress
            } else if isSecureTextEntry {
                return .password
            }
            return .generic
        }
        set {
            switch newValue {
            case .emailAddress:
                keyboardType = .emailAddress
                autocorrectionType = .no
                autocapitalizationType = .none
                isSecureTextEntry = false
                placeholder = "Email Address"

            case .password:
                keyboardType = .asciiCapable
                autocorrectionType = .no
                autocapitalizationType = .none
                isSecureTextEntry = true
                placeholder = "Password"

            case .generic:
                isSecureTextEntry = false
            }
        }
    }
    
    /// SwifterSwift: Check if text field is empty.
    var isEmpty: Bool {
        return text?.isEmpty == true
    }

    /// SwifterSwift: Return text with no spaces or new lines in beginning and end.
    var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// SwifterSwift: Check if textFields text is a valid email format.
    ///
    ///        textField.text = "john@doe.com"
    ///        textField.hasValidEmail -> true
    ///
    ///        textField.text = "swifterswift"
    ///        textField.hasValidEmail -> false
    ///
    var hasValidEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }
    
}

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

    /// SwifterSwift: Clear text.
    public func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
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
    
    /// SwifterSwift: Set placeholder text color.
    ///
    /// - Parameter color: placeholder text color.
    public func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else { return }
        attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }

    /// SwifterSwift: Add padding to the left of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the left of the textfield rect.
    public func addPaddingLeft(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }

    /// SwifterSwift: Add padding to the left of the textfield rect.
    ///
    /// - Parameters:
    ///   - image: left image
    ///   - padding: amount of padding between icon and the left of textfield
    public func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        leftView = imageView
        leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        leftViewMode = .always
    }
    
}
