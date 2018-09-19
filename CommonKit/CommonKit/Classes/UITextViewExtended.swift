//
//  UITextViewExtended.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class UITextViewExtended: UITextView, TextFieldProtocol, TextViewProtocol {
    
    open var cursorMode: CursorStateEnum = .show
    open var maximumNumberOfLines: Int {
        get { return self.textContainer.maximumNumberOfLines }
        set { self.textContainer.maximumNumberOfLines = newValue }
    }
    open var selectableContent: Bool = true
    open var maxLength: Int = 0
    open var trimText: Bool = true
    
    override open var text: String! {
        didSet { self.placeholderLabel.isHidden = !( self.placeholderLabel.text?.isEmpty ?? true ) ? self.hasText : true }
    }
    
    open var placeholder: String? {
        get { return self.placeholderLabel.text }
        set {
            self.placeholderLabel.text = newValue
            if ( !self.hasText ) { self.setNeedsUpdateConstraints() }
        }
    }
    
    open var placeHolderFont: UIFont = UIFont.systemFont(ofSize: 14.0)
    
    open lazy var placeholderLabel: UILabel = UILabel.create {
        $0.backgroundColor = UIColor.clear
        $0.font = self.placeHolderFont
        $0.textColor = UIColor.lightGray
        $0.isHidden = self.hasText ? true : ( !( $0.text?.isEmpty ?? true ) ? true : ( self.hasText ))
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    weak private var delegate2: UITextViewDelegate? = nil
    
    override weak open var delegate: UITextViewDelegate? {
        willSet { self.delegate2 = newValue }
        didSet { super.delegate = self }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.delegate = self
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        super.delegate = self
        self.addSubview(self.placeholderLabel)
        
        self.placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 1.0).isActive = true
        self.placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5.0).isActive = true
        self.placeholderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5.0).isActive = true
        self.placeholderLabel.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        self.setNeedsUpdateConstraints()
    }
}

extension UITextViewExtended: UITextViewDelegate {
    
    override open func caretRect(for position: UITextPosition) -> CGRect {
        switch self.cursorMode {
        case .show: return super.caretRect(for: position)
        case .hide: return .zero
        case .showWhenEmpty: return self.text.isEmpty ? super.caretRect(for: position) : .zero
        case .hideWhenEmpty: return self.text.isEmpty ? .zero : super.caretRect(for: position)
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        self.placeholderLabel.isHidden = !( self.placeholderLabel.text?.isEmpty ?? true ) ? self.hasText : true
        self.delegate2?.textViewDidChange?(textView)
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        self.delegate2?.textViewDidChangeSelection?(textView)
    }
    
    open func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return self.delegate2?.textViewShouldBeginEditing?(textView) ?? true
    }
    
    open func textViewDidBeginEditing(_ textView: UITextView) {
        self.delegate2?.textViewDidBeginEditing?(textView)
    }
    
    open func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        guard self.trimText else { return self.delegate2?.textViewShouldEndEditing?(textView) ?? true }
        var newLines: Array<String> = self.text.lines
        var linesChanged: Bool = false
        
        for i in 0..<self.text.lines.count {
            let newLine: String = self.text.lines[i].trimmingCharacters(in: .whitespaces)
            guard newLine != self.text.lines[i] else { continue }
            linesChanged = true
            newLines[i] = newLine
        }
        
        while ( newLines.last ?? "-" ).isEmpty {
            newLines.removeLast(1)
            linesChanged = true
        }
        
        guard linesChanged else { return self.delegate2?.textViewShouldEndEditing?(textView) ?? true }
        self.text = newLines.combined
        self.placeholderLabel.isHidden = self.hasText
        self.delegate2?.textViewDidChange?(textView)
        return self.delegate2?.textViewShouldEndEditing?(textView) ?? true
    }
    
    open func textViewDidEndEditing(_ textView: UITextView) {
        self.delegate2?.textViewDidEndEditing?(textView)
    }
    
    open func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if ((( text == " " ) && ( !self.hasText )) || (( text == " " ) && ( self.hasText ) && ( textView.text.count > 1 ) && ( textView.text.suffix(2) == "  " ))) {
            return false
        }
        
        let newText: String = textView.text.replacingCharacters(in: range, with: text)!
        var failure: Bool = false
        
        if (( self.maxLength > 0) && ( newText.count > textView.text.count )) {
            for i in 0..<newText.lines.count {
                failure = newText.lines[i].count > self.maxLength ? true : failure
            }
            if ( failure ) {
                return false
            }
            
        }
        
        return failure ? false : ( self.delegate2?.textView?(textView, shouldChangeTextIn: range, replacementText: text) ?? true )
    }
    
    open func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return self.delegate2?.textView?(textView, shouldInteractWith: URL, in: characterRange, interaction: interaction) ?? false
        
    }
    
    open func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return self.delegate2?.textView?(textView, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction) ?? false
        
    }
    
    override open func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return self.selectableContent ? super.selectionRects(for: range) : []
    }
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return (( !self.selectableContent ) && ([#selector(select(_:)), #selector(cut(_:)), #selector(delete(_:)), #selector(copy(_:)), #selector(selectAll(_:)), #selector(paste(_:))].contains(action))) ? false : super.canPerformAction(action, withSender: sender)
    }
}
