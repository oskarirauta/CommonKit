//
//  DoneBar.swift
//  NumPad
//
//  Created by Oskari Rauta on 05/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public final class DoneBar: UIToolbar {

    public private(set) var inputViewType: NumPad.InputViewType? = nil
    public private(set) weak var textInput: UITextInput? = nil

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init() {
        super.init(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: 35)))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textInput = nil
        self.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction(_:)))
        ]
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupTextInput(_:)), name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupTextInput(_:)), name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    @objc internal func setupTextInput(_ notification: Notification) {
        
        guard
            let textInput: UITextInput = notification.object as? UITextInput,
            ( self == (textInput as? UITextField)?.inputAccessoryView || self == (textInput as? UITextView)?.inputAccessoryView )
            else { return }
        
        self.textInput = textInput
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: nil)
        
        self.inputViewType = notification.name == UITextField.textDidBeginEditingNotification ? .textField : .textView
    }

    
    @objc public func doneAction(_ sender: Any) {
        
        guard
            let textInput: UITextInput = self.textInput,
            let inputViewType: NumPad.InputViewType = self.inputViewType
            else { return }
        
        switch inputViewType {
        case .textField:
            (textInput as! UITextField).resignFirstResponder()
            NotificationCenter.default.post(name: UITextField.textDidEndEditingNotification, object: textInput as! UITextField)
        case .textView:
            (textInput as! UITextView).resignFirstResponder()
            NotificationCenter.default.post(name: UITextView.textDidEndEditingNotification, object: textInput as! UITextView)
        }
    }
    
}
