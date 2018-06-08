//
//  UITextFieldExtended.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class UITextFieldExtended: UITextField, TextFieldProtocol, TextFieldHandlerProtocol {
    
    public var cursorMode: CursorStateEnum = .show
    public var maximumNumberOfLines: Int = 0
    public var selectableContent: Bool = true
    public var maxLength: Int = 0
    public var trimText: Bool = true
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(self.maxLengthHandler), for: .editingChanged)
        self.addTarget(self, action: #selector(self.trimHandler), for: .editingDidEnd)
        self.addTarget(self, action: #selector(self.trimHandler), for: .editingDidEndOnExit)
    }
    
    public init(frame: CGRect, withoutHandlers: Bool) {
        super.init(frame: frame)
        if ( !withoutHandlers ) {
            self.addTarget(self, action: #selector(self.maxLengthHandler), for: .editingChanged)
            self.addTarget(self, action: #selector(self.trimHandler), for: .editingDidEnd)
            self.addTarget(self, action: #selector(self.trimHandler), for: .editingDidEndOnExit)
        }
    }
    
}

extension UITextFieldExtended {
    
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
    
    override open func selectionRects(for range: UITextRange) -> [Any] {
        return self.selectableContent ? super.selectionRects(for: range) : []
    }
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        return (( !self.selectableContent ) && ([#selector(select(_:)), #selector(cut(_:)), #selector(delete(_:)), #selector(copy(_:)), #selector(selectAll(_:)), #selector(paste(_:))].contains(action))) ? false : super.canPerformAction(action, withSender: sender)
    }
}
