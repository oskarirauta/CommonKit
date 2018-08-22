//
//  CurrencyPad.swift
//  CurrencyKit
//
//  Created by Oskari Rauta on 23/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public final class CurrencyPad: UIInputView, UIInputViewAudioFeedback {
    
    private(set) var style: NumPad.Style = NumPad.Style.default
    private(set) var inputViewType: NumPad.InputViewType? = nil
    private(set) weak var textInput: UITextInput? = nil
    private(set) var currencyField: CurrencyFieldDelegate? = nil
    
    public var enableInputClicksWhenVisible: Bool = true
    
    public var allowSignChange: Bool = true {
        didSet {
            guard self.button.count > 10 else { return }
            self.button[10].isEnabled = self.allowSignChange
            self.button[10].isHidden = !self.allowSignChange
            print(self.allowSignChange ? "Showing" : "Hiding")
        }
    }
    
    lazy internal var overlayView: UIView = {
        var _overlayView: UIView = UIView()
        _overlayView.translatesAutoresizingMaskIntoConstraints = false
        _overlayView.backgroundColor = self.style.overlayColor
        return _overlayView
    }()
    
    lazy internal var innerView: UIView = {
        var _innerView: UIView = UIView()
        _innerView.translatesAutoresizingMaskIntoConstraints = false
        _innerView.backgroundColor = UIColor.clear
        return _innerView
    }()
    
    internal var button: [UIButton] = []
    
    public override var intrinsicContentSize: CGSize {
        get { return CGSize(width: UIViewNoIntrinsicMetric, height: UIViewNoIntrinsicMetric) }
    }
    
    public init() {
        super.init(frame: .zero, inputViewStyle: .default)
        self.setup(style: .default)
    }
    
    public init(style: NumPad.Style = .default) {
        super.init(frame: .zero, inputViewStyle: .default)
        self.setup(style: style)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupViews()
        self.setup(style: .default)
    }
    
    private override init(frame: CGRect, inputViewStyle: UIInputViewStyle) {
        super.init(frame: frame, inputViewStyle: inputViewStyle)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupViews()
        self.setup(style: .default)
    }
    
    internal func setup(style: NumPad.Style = .default) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.style = style
        self.textInput = nil
        self.setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupTextInput(_:)), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupTextInput(_:)), name: NSNotification.Name.UITextViewTextDidEndEditing, object: nil)
    }
    
    @objc internal func setupTextInput(_ notification: Notification) {
        
        guard
            let textInput: UITextInput = notification.object as? UITextInput,
            ( self == (textInput as? UITextField)?.inputView || self == (textInput as? UITextView)?.inputView )
            else { return }
        
        var delegate: CurrencyFieldDelegate? = textInput as? CurrencyFieldDelegate ?? textInput.inputDelegate as? CurrencyFieldDelegate
        
        if delegate == nil, let textField: UITextField = textInput as? UITextField, let delegate2: CurrencyFieldDelegate = textField.delegate as? CurrencyFieldDelegate {
            delegate = delegate2
        }

        if delegate == nil, let textView: UITextView = textInput as? UITextView, let delegate2: CurrencyFieldDelegate = textView.delegate as? CurrencyFieldDelegate {
            delegate = delegate2
        }

        self.currencyField = delegate
        
        self.textInput = textInput
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidBeginEditing, object: nil)
        
        self.inputViewType = notification.name == NSNotification.Name.UITextFieldTextDidBeginEditing ? .textField : .textView
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        
        super.willMove(toSuperview: newSuperview)
        self.updateState()
    }
        
}
