//
//  CurrencyField.swift
//  CurrencyKit
//
//  Created by Oskari Rauta on 23/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class CurrencyField: UITextField, CurrencyFieldDelegate, UITextFieldDelegate {
    
    open var value: Money? = nil {
        didSet {
            if ( oldValue == nil ) { self.value?.locale = self.locale }
            self.text = self.value?.description ?? nil
        }
    }
    
    open var maximum: Int = 0 {
        didSet {
            guard !( self.maximum < 0 ) else {
                self.maximum = abs(self.maximum)
                return
            }
            
            guard
                var value: Money = self.value,
                self.maximum != 0,
                value.rawValue != 0,
                abs(value.rawValue) > Decimal(integerLiteral: self.maximum)
                else { return }

            self.value?.rawValue = value.isNegative ? Decimal(integerLiteral: -self.maximum): Decimal(integerLiteral: self.maximum)
        }
    }
    
    public var allowSignChange: Bool {
        get { return self.currencyPad.allowSignChange }
        set { self.currencyPad.allowSignChange = newValue }
    }
    
    open var locale: Locale = Locale.appLocale {
        didSet { self.value?.locale = self.locale }
    }

    internal lazy var currencyPad: CurrencyPad = CurrencyPad(style: .default)
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.inputView = self.currencyPad
        self.inputAccessoryView = DoneBar()
        self.delegate = self
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.inputView = self.currencyPad
        self.inputAccessoryView = DoneBar()
        self.delegate = self
    }
    
    open override func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
 
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if ( self.value == nil ) { self.value = 0 }
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.value = nil
        return false
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }

    open func pressNumber(number: Int) {
        
        guard self.value != 0 || number != 0 else { return }
        
        guard let value: Money = self.value else {
            self.value = Money(Decimal(number) * 0.01)
            return
        }

        let newValue: Money = Money(( value.rawValue * 10 ) + ( value.isNegative ? -(Decimal(number) * 0.01) : (Decimal(number) * 0.01)))
        
        guard self.maximum == 0 || abs(newValue.rawValue) <= Decimal(self.maximum) else {
            self.warnSyntaxError()
            return
        }
        
        self.value = newValue
        self.sendActions(for: .valueChanged)
    }
    
    open func pressBackspace() {
        guard
            var value: Money = self.value,
            value.rawValue != 0
            else { return }

        func lastDecimal(of sum: Decimal) -> Decimal {
            let s: String = String(sum.rounded(to: 2).doubleValue)
            if ( String(s.charAt(s.count - 2)) == ( Locale.current.decimalSeparator ?? "." )) {
                return 0
            }
            return Decimal(floatLiteral: Double(Int(s.last!.string)!) * 0.01)
        }

        var newValue: Decimal = value.rawValue
        newValue = ( newValue - lastDecimal(of: newValue)) * 0.1
        self.value = Money(newValue)
        self.sendActions(for: .valueChanged)
    }
    
    open func pressSignToggle() {
        guard
            var value: Money = self.value,
            value.rawValue != 0
            else { return }
        value.rawValue = -value.rawValue
        self.value = value
        self.sendActions(for: .valueChanged)
    }

}
