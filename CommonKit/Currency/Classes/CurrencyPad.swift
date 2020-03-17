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
    
    private(set) var style: NumPadStyle = .default
    private(set) var inputViewType: NumPad.InputViewType? = nil
    private(set) weak var textInput: UITextInput? = nil
    private(set) var currencyField: CurrencyFieldDelegate? = nil
    
    public var enableInputClicksWhenVisible: Bool = true
    
    public var allowSignChange: Bool = true {
        didSet {
            guard self.button.count > 10 else { return }
            self.button[10].isEnabled = self.allowSignChange
            self.button[10].isHidden = !self.allowSignChange
        }
    }

    internal lazy var overlayView: UIView = UIView.create {
        [unowned self] in
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = self.style.overlayColor
    }
    
    internal lazy var innerView: UIView = UIView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
    }
    
    internal var button: [UIButton] = []
    
    override public var intrinsicContentSize: CGSize {
        get { return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric) }
    }
    
    public init() {
        super.init(frame: .zero, inputViewStyle: .default)
        self.setup(style: .default)
    }
    
    public init(style: NumPadStyle = .default) {
        super.init(frame: .zero, inputViewStyle: .default)
        self.setup(style: style)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupViews()
        self.setup(style: .default)
    }
    
    override private init(frame: CGRect, inputViewStyle: UIInputView.Style) {
        super.init(frame: frame, inputViewStyle: inputViewStyle)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupViews()
        self.setup(style: .default)
    }
    
    internal func setup(style: NumPadStyle = .default) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.style = style
        self.textInput = nil
        self.setupViews()
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupTextInput(_:)), name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupTextInput(_:)), name: UITextView.textDidEndEditingNotification, object: nil)
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
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: nil)
        
        self.inputViewType = notification.name == UITextField.textDidBeginEditingNotification ? .textField : .textView
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        
        super.willMove(toSuperview: newSuperview)
        self.updateState()
    }
        
}
