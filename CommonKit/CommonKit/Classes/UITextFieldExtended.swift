//
//  UITextFieldExtended.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    open class Extended: UITextField, TextFieldProtocol, TextFieldHandlerProtocol {
                
            open var cursorMode: CursorStateEnum = .show
            open var maximumNumberOfLines: Int = 0
            open var selectableContent: Bool = true
            open var maxLength: Int = 0
            open var trimText: Bool = true
            open var customClosestPosition: ((CGPoint, UITextPosition?)->(UITextPosition?))? = nil
            open var customSelectionRects: ((UITextRange, [UITextSelectionRect]) -> ([UITextSelectionRect]))? = nil
            
            open override var placeholder: String? {
                get { return self.attributedPlaceholder?.string }
                set {
                    self.attributedPlaceholder = newValue == nil ? nil : NSAttributedString(string: newValue ?? "", attributes: [
                        NSAttributedString.Key.foregroundColor: UIColor.placeholderColor,
                        NSAttributedString.Key.font: UIFont.systemFont(ofSize: ( iphoneCompatible ? 13.5 : 20.0 ))
                    ])
                }
            }
        
            public required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
            }
            
            override public init(frame: CGRect) {
                super.init(frame: frame)
                self.font = .systemFont(ofSize: ( iphoneCompatible ?  13.5 : 19.0 ))
                self.addTarget(self, action: #selector(self.maxLengthHandler), for: .editingChanged)
                self.addTarget(self, action: #selector(self.trimHandler), for: .editingDidEnd)
                self.addTarget(self, action: #selector(self.trimHandler), for: .editingDidEndOnExit)
            }
            
            public init(frame: CGRect, withoutHandlers: Bool) {
                super.init(frame: frame)
                self.font = .systemFont(ofSize: ( iphoneCompatible ?  13.5 : 19.0 ))
                if ( !withoutHandlers ) {
                    self.addTarget(self, action: #selector(self.maxLengthHandler), for: .editingChanged)
                    self.addTarget(self, action: #selector(self.trimHandler), for: .editingDidEnd)
                    self.addTarget(self, action: #selector(self.trimHandler), for: .editingDidEndOnExit)
                }
            }
            
        }
    
}

extension UITextField.Extended {
        
        override open func caretRect(for position: UITextPosition) -> CGRect {
            switch self.cursorMode {
            case .show: return super.caretRect(for: position)
            case .hide: return .zero
            case .showWhenEmpty: return ( self.text?.isEmpty ?? true ) ? super.caretRect(for: position) : .zero
            case .hideWhenEmpty: return ( self.text?.isEmpty ?? true ) ? .zero : super.caretRect(for: position)
            }
        }
        
        open func maxLengthHandler() {
            guard self.maxLength > 0, self.text != nil, self.text!.count > self.maxLength else { return }
            self.text = String(Array(self.text ?? "").prefix(self.maxLength))
        }
        
        open func trimHandler() {
            guard self.trimText, !(self.text?.isEmpty ?? true) else { return }
            self.text = self.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        override open func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
            return self.selectableContent ? ( self.customSelectionRects?(range, super.selectionRects(for: range)) ?? super.selectionRects(for: range)) : []
        }
        
        override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            
            return (( !self.selectableContent ) && ([#selector(select(_:)), #selector(cut(_:)), #selector(delete(_:)), #selector(copy(_:)), #selector(selectAll(_:)), #selector(paste(_:))].contains(action))) ? false : super.canPerformAction(action, withSender: sender)
        }
        
        override open func closestPosition(to point: CGPoint) -> UITextPosition? {
            return self.customClosestPosition?(point, super.closestPosition(to: point)) ?? super.closestPosition(to: point)
        }
}
