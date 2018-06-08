//
//  AlertController.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class AlertController: DefaultAlertControllerBaseClass, DefaultAlertActionProtocol, UITextFieldDelegate {

    // Settings
    open private(set) var tinyButtons: Bool = true
    
    open var titleFont: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 16.5)!
    open var titleTextColor: UIColor = UIColor(red:77/255, green:77/255, blue:77/255, alpha:1.0)
    
    open var messageFont: UIFont = UIFont(name: "HelveticaNeue", size: 14.5)!
    open var messageTextColor: UIColor = UIColor(red:77/255, green:77/255, blue:77/255, alpha:1.0)
    
    open var textFieldBorderColor: UIColor = UIColor(red: 203.0/255, green: 203.0/255, blue: 203.0/255, alpha: 1.0)
    open var textFieldBgColor: UIColor = UIColor.white
    open var textFieldHeight: CGFloat = 30.0
    open var textFieldCornerRadius: CGFloat = 4.0
    
    open lazy var buttonFont: [AlertActionStyle: UIFont] = self.defaultButtonFonts
    open lazy var buttonTextColor: [AlertActionStyle: UIColor] = self.defaultButtonTextColors
    open lazy var buttonBgColor: [AlertActionStyle: UIColor] = self.defaultButtonBgColors
    open lazy var buttonBgColorHighlighted: [AlertActionStyle: UIColor] = self.defaultButtonBgColorHighlighteds
    
    // Message
    open var message: String? = nil
    
    // TextAreaScrollView
    fileprivate var textAreaHeight: CGFloat = 0.0
    open lazy var textAreaScrollView: UIScrollView = {
        [unowned self] in
        var _textAreaScrollView: UIScrollView = UIScrollView()
        _textAreaScrollView.translatesAutoresizingMaskIntoConstraints = false
        _textAreaScrollView.addSubview(self.textAreaView)
        return _textAreaScrollView
        }()
    
    // TextAreaView
    open lazy var textAreaView: UIView = {
        [unowned self] in
        var _textAreaView: UIView = UIView()
        _textAreaView.translatesAutoresizingMaskIntoConstraints = false
        _textAreaView.addSubview(self.textContainer)
        return _textAreaView
        }()
    
    // TextContainer
    open lazy var textContainer: UIView = {
        [unowned self] in
        var _textContainer: UIView = UIView()
        _textContainer.translatesAutoresizingMaskIntoConstraints = false
        return _textContainer
        }()
    open var textContainerHeightConstraint: NSLayoutConstraint? = nil
    
    // ButtonAreaScrollView
    open lazy var buttonAreaScrollView: UIScrollView = {
        [unowned self] in
        var _buttonAreaScrollView: UIScrollView = UIScrollView()
        _buttonAreaScrollView.translatesAutoresizingMaskIntoConstraints = false
        _buttonAreaScrollView.addSubview(self.buttonAreaView)
        return _buttonAreaScrollView
        }()
    open var buttonAreaScrollViewHeightConstraint: NSLayoutConstraint? = nil
    open var buttonAreaHeight: CGFloat = 0.0
    
    // ButtonAreaView
    open lazy var buttonAreaView: UIView = {
        [unowned self] in
        var _buttonAreaView: UIView = UIView()
        _buttonAreaView.translatesAutoresizingMaskIntoConstraints = false
        _buttonAreaView.addSubview(self.buttonContainer)
        return _buttonAreaView
        }()
    
    // TitleLabel
    open lazy var titleLabel: UILabel = {
        [unowned self] in
        var _titleLabel: UILabel = UILabel()
        _titleLabel.frame.size = CGSize(width: self.innerContentWidth, height: 0.0)
        _titleLabel.numberOfLines = 0
        _titleLabel.textAlignment = .center
        _titleLabel.font = self.titleFont
        _titleLabel.textColor = self.titleTextColor
        return _titleLabel
        }()
    
    // MessageView
    open lazy var messageView: UILabel = {
        [unowned self] in
        var _messageView: UILabel = UILabel()
        _messageView.frame.size = CGSize(width: self.innerContentWidth, height: 0.0)
        _messageView.numberOfLines = 0
        _messageView.textAlignment = .center
        _messageView.font = self.messageFont
        _messageView.textColor = self.messageTextColor
        return _messageView
        }()
    
    // TextFieldContainerView
    open lazy var textFieldContainerView: UIView = {
        [unowned self] in
        var _textFieldContainerView: UIView = UIView()
        _textFieldContainerView.backgroundColor = self.textFieldBorderColor
        _textFieldContainerView.layer.masksToBounds = true
        _textFieldContainerView.layer.cornerRadius = self.textFieldCornerRadius
        _textFieldContainerView.layer.borderWidth = 0.5
        _textFieldContainerView.layer.borderColor = self.textFieldBorderColor.cgColor
        return _textFieldContainerView
        }()
    
    // ButtonContainer
    open lazy var buttonContainer: UIView = {
        [unowned self] in
        var _buttonContainer: UIView = UIView()
        _buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        return _buttonContainer
        }()
    open var buttonContainerHeightConstraint: NSLayoutConstraint? = nil
    
    // TextFields
    open private(set) var textFields: [AnyObject]?
    
    // Actions
    open private(set) var actions: [AnyObject] = []
    
    // Buttons
    open var buttons: Array<AlertButton> = []
    open var cancelButtonTag: Int? = nil
    
    open var keyboardHeight: CGFloat = 0.0
    
    public init(title: String?, message: String?, preferredStyle: AlertControllerStyle) {
        super.init(nibName: nil, bundle: nil)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overCurrentContext
        self.title = title
        self.message = message
        self._preferredStyle = preferredStyle
        self.setupView()
        self.setupConstraints()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func setupNotifications() {
        // NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleAlertActionEnabledDidChangeNotification(_:)), name: NSNotification.Name(rawValue: AlertActionEnabledDidChangeNotification), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    open override func setupView() {
        super.setupView()
        self.contentView.addSubview(self.textAreaScrollView)
        self.contentView.addSubview(self.buttonAreaScrollView)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (( self.preferredStyle != .alert ) && ( self.cancelButtonTag != nil )) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AlertController.handleContainerViewTapGesture(_:)))
            self.containerView.addGestureRecognizer(tapGesture)
        }
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.layoutView(self.presentingViewController)
    }
    
    open override func setupConstraints() {
        
        super.setupConstraints()
        
        // TextAreaScrollView
        self.textAreaScrollView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.textAreaScrollView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.textAreaScrollView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.textAreaScrollView.bottomAnchor.constraint(equalTo: self.buttonAreaScrollView.topAnchor).isActive = true
        
        // ButtonAreaScrollView
        self.buttonAreaScrollView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.buttonAreaScrollView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.buttonAreaScrollView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: self.preferredStyle == .alert ? 0.0 : -self.actionSheetBounceHeight).isActive = true
        self.buttonAreaScrollViewHeightConstraint = self.buttonAreaScrollView.heightAnchor.constraint(equalToConstant: 0.0)
        self.buttonAreaScrollViewHeightConstraint?.isActive = true
        
        // TextAreaView
        self.textAreaView.topAnchor.constraint(equalTo: self.textAreaScrollView.topAnchor).isActive = true
        self.textAreaView.centerXAnchor.constraint(equalTo: self.textAreaScrollView.centerXAnchor).isActive = true
        self.textAreaView.leadingAnchor.constraint(equalTo: self.textAreaScrollView.leadingAnchor).isActive = true
        self.textAreaView.trailingAnchor.constraint(equalTo: self.textAreaScrollView.trailingAnchor).isActive = true
        self.textAreaView.bottomAnchor.constraint(equalTo: self.textAreaScrollView.bottomAnchor).isActive = true
        self.textAreaView.heightAnchor.constraint(equalTo: self.textContainer.heightAnchor).isActive = true
        self.textAreaView.widthAnchor.constraint(equalTo: self.textAreaScrollView.widthAnchor).isActive = true
        
        // TextContainer
        self.textContainer.topAnchor.constraint(equalTo: self.textAreaView.topAnchor).isActive = true
        self.textContainer.centerXAnchor.constraint(equalTo: self.textAreaView.centerXAnchor).isActive = true
        self.textContainer.widthAnchor.constraint(equalToConstant: self.innerContentWidth).isActive = true
        self.textContainerHeightConstraint = self.textContainer.heightAnchor.constraint(equalToConstant: 0.0)
        self.textContainerHeightConstraint?.isActive = true
        
        // ButtonAreaView
        self.buttonAreaView.topAnchor.constraint(equalTo: self.buttonAreaScrollView.topAnchor).isActive = true
        self.buttonAreaView.leadingAnchor.constraint(equalTo: self.buttonAreaScrollView.leadingAnchor).isActive = true
        self.buttonAreaView.trailingAnchor.constraint(equalTo: self.buttonAreaScrollView.trailingAnchor).isActive = true
        self.buttonAreaView.bottomAnchor.constraint(equalTo: self.buttonAreaScrollView.bottomAnchor).isActive = true
        self.buttonAreaView.widthAnchor.constraint(equalTo: self.buttonAreaScrollView.widthAnchor).isActive = true
        self.buttonAreaView.heightAnchor.constraint(equalTo: self.buttonContainer.heightAnchor).isActive = true
        
        // ButtonContainer
        self.buttonContainer.topAnchor.constraint(equalTo: self.buttonAreaView.topAnchor).isActive = true
        self.buttonContainer.centerXAnchor.constraint(equalTo: self.buttonAreaView.centerXAnchor).isActive = true
        self.buttonContainer.widthAnchor.constraint(equalToConstant: self.innerContentWidth).isActive = true
        self.buttonContainerHeightConstraint = self.buttonContainer.heightAnchor.constraint(equalToConstant: 0.0)
        self.buttonContainerHeightConstraint?.isActive = true
        
    }
    
    open override func layoutView(_ presenting: UIViewController?) {
        
        guard self.layoutFlg == false else { return }
        self.layoutFlg = true
        
        // TextArea Layout
        let hasTitle: Bool = ( self.title ?? "" ) != ""
        let hasMessage: Bool = ( self.message ?? "" ) != ""
        let hasTextField: Bool = ( self.textFields?.count ?? 0 ) != 0
        
        var textAreaPositionY: CGFloat = self.preferredStyle == .alert ? ( 2 * alertViewPadding ) : alertViewPadding
        
        if ( hasTitle ) {
            self.titleLabel.text = self.title
            self.titleLabel.sizeToFit()
            self.titleLabel.frame = CGRect(x: 0, y: textAreaPositionY, width: self.innerContentWidth, height: self.titleLabel.frame.height)
            self.textContainer.addSubview(self.titleLabel)
            textAreaPositionY += self.titleLabel.frame.height + 5.0
        }
        
        if ( hasMessage ) {
            self.messageView.text = self.message
            self.messageView.sizeToFit()
            messageView.frame = CGRect(x: 0, y: textAreaPositionY, width: innerContentWidth, height: messageView.frame.height)
            self.textContainer.addSubview(self.messageView)
            textAreaPositionY += self.messageView.frame.height + 5.0
        }
        
        // TextFieldContainerView
        if ( hasTextField ) {
            
            textAreaPositionY += (( hasTitle ) || ( hasMessage )) ? 5.0 : 0.0
            self.textContainer.addSubview(self.textFieldContainerView)
            
            var textFieldContainerHeight: CGFloat = 0.0
            
            // TextFields
            for (_, obj) in (self.textFields!).enumerated() {
                let textField = obj as! UITextFieldExtended
                textField.frame = CGRect(x: 0.0, y: textFieldContainerHeight, width: innerContentWidth, height: textField.frame.height)
                textFieldContainerHeight += textField.frame.height + 0.5
            }
            
            textFieldContainerHeight -= 0.5
            textFieldContainerView.frame = CGRect(x: 0.0, y: textAreaPositionY, width: innerContentWidth, height: textFieldContainerHeight)
            
            textAreaPositionY += textFieldContainerHeight + 5.0
            
        }
        
        // TextAreaScrollView
        self.textAreaHeight = (( hasTitle ) || ( hasMessage ) || ( hasTextField )) ? textAreaPositionY : 0.0
        textAreaScrollView.contentSize = CGSize(width: alertViewWidth, height: self.textAreaHeight)
        self.textContainerHeightConstraint?.constant = self.textAreaHeight
        
        // ButtonArea Layout
        var buttonAreaPositionY: CGFloat = self.buttonMargin
        
        // Buttons
        if (( self.preferredStyle == .alert ) && ((( self.tinyButtons ) && ([2,3].contains(self.buttons.count))) || (( !self.tinyButtons ) && ( self.buttons.count == 2 )))) {
            let buttonWidth: CGFloat = self.buttons.count == 2 ? (( self.innerContentWidth - self.buttonMargin) / 2 ) : (( self.innerContentWidth - ( self.buttonMargin * 2 )) / 3 )
            var buttonPositionX: CGFloat = 0.0
            for button in self.buttons {
                button.frame = CGRect(x: buttonPositionX, y: buttonAreaPositionY, width: buttonWidth, height: self.buttonHeight)
                buttonPositionX += self.buttonMargin + buttonWidth
            }
            buttonAreaPositionY += self.buttonHeight
        } else {
            
            for button in self.buttons {
                let action: AlertAction = self.actions[button.tag - 1] as! AlertAction
                if ( action.style != .cancel ) {
                    button.frame = CGRect(x: 0, y: buttonAreaPositionY, width: self.innerContentWidth, height: self.buttonHeight)
                    buttonAreaPositionY += self.buttonHeight + self.buttonMargin
                } else {
                    self.cancelButtonTag = button.tag
                }
            }
        }
        
        // Cancel Button
        if ( self.cancelButtonTag != nil ) {
            
            if (( self.preferredStyle == .alert ) && ( self.buttons.count > 1 )) {
                buttonAreaPositionY += self.buttonMargin
            }
            
            let button: AlertButton = self.buttonAreaScrollView.viewWithTag(self.cancelButtonTag!) as! AlertButton
            //let action: AlertAction = self.actions[self.cancelButtonTag! - 1] as! AlertAction
            button.frame = CGRect(x: 0, y: buttonAreaPositionY, width: self.innerContentWidth, height: self.buttonHeight)
            buttonAreaPositionY += self.buttonHeight + self.buttonMargin
        }
        
        buttonAreaPositionY += self.alertViewPadding
        buttonAreaPositionY = self.buttons.count == 0 ? 0.0 : buttonAreaPositionY
        
        // ButtonAreaScrollView Height
        self.buttonAreaHeight = buttonAreaPositionY
        self.buttonAreaScrollView.contentSize = CGSize(width: alertViewWidth, height: self.buttonAreaHeight)
        self.buttonContainerHeightConstraint?.constant = self.buttonAreaHeight
        
        // AlertView Layout
        self.reloadAlertViewHeight()
        self.contentView.frame.size = CGSize(width: self.alertViewWidth, height: self.contentViewHeightConstraint?.constant ?? 150.0 )
        
    }
    
    // Reload AlertView Height
    func reloadAlertViewHeight() {
        
        var screenSize: CGSize = self.presentingViewController != nil ? self.presentingViewController!.view.bounds.size : UIScreen.main.bounds.size
        if ((( UIDevice.current.systemVersion as NSString).floatValue < 8.0 ) && ( UIInterfaceOrientationIsLandscape(self.currentOrientation))) {
            screenSize = CGSize(width: screenSize.height, height: screenSize.width)
        }
        let maxHeight: CGFloat = screenSize.height - self.keyboardHeight
        
        // for avoiding constraint error
        self.buttonAreaScrollViewHeightConstraint?.constant = 0.0
        
        // ContentView Height Constraint
        var contentViewHeight: CGFloat = ( self.textAreaHeight + buttonAreaHeight ) > maxHeight ? maxHeight : ( self.textAreaHeight + buttonAreaHeight )
        
        if ( self.preferredStyle == .actionSheet ) { contentViewHeight += self.actionSheetBounceHeight }
        
        self.contentViewHeightConstraint?.constant = contentViewHeight
        
        // ButtonAreaScrollView Height Constraint
        let buttonAreaScrollViewHeight: CGFloat = self.buttonAreaHeight > maxHeight ? maxHeight : self.buttonAreaHeight
        self.buttonAreaScrollViewHeightConstraint?.constant = buttonAreaScrollViewHeight
    }
    
    // Button Tapped Action
    @objc func buttonTapped(_ sender: UIButton) {
        
        sender.isSelected = true
        let action = actions[sender.tag - 1] as! AlertAction
        action.handler?(action)
        self.dismiss(animated: true, completion: nil)
    }
    
    // Handle ContainerView tap gesture
    @objc func handleContainerViewTapGesture(_ sender: AnyObject) {
        
        // cancel action
        guard self.cancelButtonTag != nil else { return }
        
        let action = actions[self.cancelButtonTag! - 1] as! AlertAction
        action.handler?(action)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK : Handle NSNotification Method
    
    @objc func handleAlertActionEnabledDidChangeNotification(_ notification: Notification) {
        
        for i in 0..<self.buttons.count {
            buttons[i].isEnabled = actions[i].enabled
        }
    }
    
    @objc func handleKeyboardWillShowNotification(_ notification: Notification) {
        
        guard
            !self.fullscreen,
            let userInfo = notification.userInfo as? [String: NSValue],
            let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey]?.cgRectValue.size
            else { return }
        
        var _keyboardSize = keyboardSize
        if ((UIDevice.current.systemVersion as NSString).floatValue < 8.0) {
            if (UIInterfaceOrientationIsLandscape(self.currentOrientation)) {
                _keyboardSize = CGSize(width: _keyboardSize.height, height: _keyboardSize.width)
            }
        }
        self.keyboardHeight = _keyboardSize.height
        self.reloadAlertViewHeight()
        self.containerViewBottomConstraint?.constant = -self.keyboardHeight
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func handleKeyboardWillHideNotification(_ notification: Notification) {
        
        guard !self.fullscreen else { return }
        
        self.keyboardHeight = 0.0
        self.reloadAlertViewHeight()
        self.containerViewBottomConstraint?.constant = self.keyboardHeight
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    // Attaches an action object to the alert or action sheet.
    open func addAction(_ action: AlertAction) {
        // Error
        if ( action.style == .cancel ) {
            for ac in self.actions as! [AlertAction] {
                if ( ac.style == .cancel ) {
                    let error: NSError? = nil
                    NSException.raise(NSExceptionName(rawValue: "NSInternalInconsistencyException"), format:"AlertController can only have one action with a style of AlertActionStyleCancel", arguments:getVaList([error ?? "nil"]))
                    return
                }
            }
        }
        
        // Add Action
        self.actions.append(action)
        
        // Add Button
        var button: AlertButton = AlertButton()
        self.setButton(&button, style: action.style, controllerStyle: self.preferredStyle)
        button.setTitle(action.title)
        button.isEnabled = action.enabled
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        button.tag = buttons.count + 1
        self.buttons.append(button)
        self.buttonContainer.addSubview(button)
    }
    
    // Adds a text field to an alert.
    open func addTextFieldWithConfigurationHandler(_ configurationHandler: ((UITextFieldExtended?) -> ())?) {
        
        // Textfield is only allowed for .alert style
        
        guard self.preferredStyle == .alert else {
            let error: NSError? = nil
            NSException.raise(NSExceptionName(rawValue: "NSInternalInconsistencyException"), format: "Text fields can only be added to an alert controller of style DOAlertControllerStyleAlert", arguments:getVaList([error ?? "nil"]))
            return
        }
        
        if ( self.textFields == nil ) {
            textFields = []
        }
        
        let textField: UITextFieldExtended = UITextFieldExtended()
        textField.frame.size = CGSize(width: self.innerContentWidth, height: self.textFieldHeight)
        textField.borderStyle = UITextBorderStyle.none
        textField.backgroundColor = self.textFieldBgColor
        textField.delegate = self
        
        configurationHandler?(textField)
        
        self.textFields!.append(textField)
        self.textFieldContainerView.addSubview(textField)
    }
    
    // MARK: UITextFieldDelegate Methods
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if ( textField.canResignFirstResponder ) {
            textField.resignFirstResponder()
            self.dismiss(animated: true, completion: nil)
        }
        return true
    }
    
}
