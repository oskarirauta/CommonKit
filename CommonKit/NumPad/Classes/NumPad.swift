//
//  NumPad.swift
//  NumPad
//
//  Created by Oskari Rauta on 04/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public final class NumPad: UIInputView, UIInputViewAudioFeedback {

    private(set) var type: KeyboardType = .number
    private(set) var style: NumPadStyle = .default
    private(set) var inputViewType: InputViewType? = nil
    private(set) weak var textInput: UITextInput? = nil

    public var enableInputClicksWhenVisible: Bool = true
 
    public var cursorOffset: Int {
        return self.textInput!.offset(from: textInput!.beginningOfDocument, to: textInput!.selectedTextRange?.start ?? textInput!.endOfDocument)
    }
    
    public static var decimalChar: String {
        get { return Locale.appLocale.decimalSeparator ?? "." }
    }
    
    public var decimalChar: String {
        get { return NumPad.decimalChar }
    }
    
    internal var value: String? {
        get {
            guard
                let textInput: UITextInput = self.textInput,
                let range: UITextRange = textInput.textRange(from: textInput.beginningOfDocument, to: textInput.endOfDocument)
                else { return nil }

            return textInput.text(in: range)
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
        get { return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric) }
    }

    public init() {
        super.init(frame: .zero, inputViewStyle: .default)
        self.setup(type: .number, style: .default)
    }
    
    public init(type: KeyboardType = KeyboardType.number) {
        super.init(frame: .zero, inputViewStyle: .default)
        self.setup(type: type, style: .default)
    }
    
    public init(style: NumPadStyle = .default) {
        super.init(frame: .zero, inputViewStyle: .default)
        self.setup(type: .number, style: style)
    }
    
    public init(type: KeyboardType = .number, style: NumPadStyle = .default) {
        super.init(frame: .zero, inputViewStyle: .default)
        self.setup(type: type, style: style)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupViews()
        self.setup(type: .number, style: .default)
    }
    
    private override init(frame: CGRect, inputViewStyle: UIInputView.Style) {
        super.init(frame: frame, inputViewStyle: inputViewStyle)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupViews()
        self.setup(type: .number, style: .default)
    }
    
    internal func setup(type: KeyboardType = .number, style: NumPadStyle = .default) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.type = type
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
        
        self.textInput = textInput
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: nil)
        
        self.inputViewType = notification.name == UITextField.textDidBeginEditingNotification ? .textField : .textView
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        
        super.willMove(toSuperview: newSuperview)
        
        guard newSuperview == nil, let textInput: UITextInput = self.textInput else {
            self.updateState()
            return
        }
            
        if (( self.value == self.decimalChar ) || ( self.value == "+" )) {
            if let range: UITextRange = textInput.textRange(from: textInput.beginningOfDocument, to: textInput.endOfDocument) {
                textInput.replace(range, withText: "")
            }
        } else if (( self.type == .decimal ) && ( self.value?.first == self.decimalChar.first ) && ( self.decimalChar.first != nil )) {
            if
                let position: UITextPosition = textInput.position(from: textInput.beginningOfDocument, offset: 1),
                let range: UITextRange = textInput.textRange(from: textInput.beginningOfDocument, to: position) {
                textInput.replace(range, withText: "0" + self.decimalChar)
            }
        } else if (( self.type == .phone ) && (( self.value?.contains("+") ?? false))) {
            let beginsWithPlus: Bool = self.value?.first == "+" ? true : false
            let newText: String = ( beginsWithPlus ? "+" : "" ) + ( self.value ?? "" ).replacingOccurrences(of: "+", with: "")
            if let range: UITextRange = textInput.textRange(from: textInput.beginningOfDocument, to: textInput.endOfDocument) {
                textInput.replace(range, withText: newText != "+" ? newText : "" )
            }
        }
        
        self.updateState()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard self.type == .phone else { return }
        let numberOfLines: Int = UIDevice.current.orientation.isPortrait ? 2 : 1
        self.button.enumerated().forEach {
            guard $0 < 10 else { return }
            $1.titleLabel?.numberOfLines = numberOfLines
        }
    }

}
