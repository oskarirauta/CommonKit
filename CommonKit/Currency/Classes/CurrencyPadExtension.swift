//
//  CurrencyPadExtension.swift
//  CurrencyKit
//
//  Created by Oskari Rauta on 23/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension CurrencyPad {
    
    internal func setupViews() {
        self.addSubview(self.overlayView)
        self.overlayView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.overlayView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.overlayView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.overlayView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.overlayView.addSubview(self.innerView)
        self.innerView.topAnchor.constraint(equalTo: self.overlayView.topAnchor).isActive = true
        self.innerView.centerXAnchor.constraint(equalTo: self.overlayView.centerXAnchor).isActive = true
        self.innerView.leadingAnchor.constraint(equalTo: self.overlayView.leadingAnchor).withPriority(999).isActive = true
        self.innerView.trailingAnchor.constraint(equalTo: self.overlayView.trailingAnchor).withPriority(999).isActive = true
        self.innerView.bottomAnchor.constraint(equalTo: self.overlayView.bottomAnchor).isActive = true
        self.innerView.widthAnchor.constraint(lessThanOrEqualToConstant: 360.0).withPriority(1000).isActive = true
        
        guard self.button.count == 0 else { return }
        
        let buttonTitles: [String] = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" ]
        
        for i in 0...9 {
            self.button.append(NumPad.NumPadButton(type: .number, style: self.style, title: buttonTitles[i], tag: i, handler: self.buttonHandler(_:)))
        }
        
        self.button.append(CurrencyFunctionButton(style: self.style, handler: self.buttonHandler(_:)))
        self.button.append(NumPad.NumPadBackspaceButton(style: self.style, handler: self.buttonHandler(_:)))
        
        self.button[10].isEnabled = self.allowSignChange
        self.button[10].isHidden = !self.allowSignChange
        
        self.button.forEach { self.innerView.addSubview($0) }
        
        self.button[2].centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        self.button[5].centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        self.button[8].centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        self.button[0].centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        
        self.button[1].topAnchor.constraint(equalTo: self.innerView.topAnchor, constant: 6.0).isActive = true
        self.button[2].topAnchor.constraint(equalTo: self.innerView.topAnchor, constant: 6.0).isActive = true
        self.button[3].topAnchor.constraint(equalTo: self.innerView.topAnchor, constant: 6.0).isActive = true
        
        self.button[1].leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor, constant: 9.0).isActive = true
        self.button[4].leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor, constant: 9.0).isActive = true
        self.button[7].leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor, constant: 9.0).isActive = true
        
        self.button[3].trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor, constant: -12.0).isActive = true
        self.button[6].trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor, constant: -12.0).isActive = true
        self.button[9].trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor, constant: -12.0).isActive = true
        
        self.button[10].leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor, constant: 12.0).isActive = true
        self.button[11].trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor, constant: -12.0).isActive = true
        
        self.button[1].trailingAnchor.constraint(equalTo: self.button[2].leadingAnchor, constant: -12.0).isActive = true
        self.button[4].trailingAnchor.constraint(equalTo: self.button[5].leadingAnchor, constant: -12.0).isActive = true
        self.button[7].trailingAnchor.constraint(equalTo: self.button[8].leadingAnchor, constant: -12.0).isActive = true
        
        self.button[3].leadingAnchor.constraint(equalTo: self.button[2].trailingAnchor, constant: 9.0).isActive = true
        self.button[6].leadingAnchor.constraint(equalTo: self.button[5].trailingAnchor, constant: 9.0).isActive = true
        self.button[9].leadingAnchor.constraint(equalTo: self.button[8].trailingAnchor, constant: 9.0).isActive = true
        
        self.button[4].topAnchor.constraint(equalTo: self.button[1].bottomAnchor, constant: 12.0).isActive = true
        self.button[5].topAnchor.constraint(equalTo: self.button[2].bottomAnchor, constant: 12.0).isActive = true
        self.button[6].topAnchor.constraint(equalTo: self.button[3].bottomAnchor, constant: 12.0).isActive = true
        
        self.button[7].topAnchor.constraint(equalTo: self.button[4].bottomAnchor, constant: 12.0).isActive = true
        self.button[8].topAnchor.constraint(equalTo: self.button[5].bottomAnchor, constant: 12.0).isActive = true
        self.button[9].topAnchor.constraint(equalTo: self.button[6].bottomAnchor, constant: 12.0).isActive = true
        
        self.button[10].trailingAnchor.constraint(equalTo: self.button[0].leadingAnchor, constant: -12.0).isActive = true
        self.button[11].leadingAnchor.constraint(equalTo: self.button[0].trailingAnchor, constant: 12.0).isActive = true
        
        self.button[10].topAnchor.constraint(equalTo: self.button[7].bottomAnchor, constant: 12.0).isActive = true
        self.button[0].topAnchor.constraint(equalTo: self.button[8].bottomAnchor, constant: 12.0).isActive = true
        self.button[11].topAnchor.constraint(equalTo: self.button[9].bottomAnchor, constant: 12.0).isActive = true
        
        self.button[0].bottomAnchor.constraint(equalTo: self.innerView.bottomAnchor, constant: -8.0).isActive = true
        self.button[10].bottomAnchor.constraint(equalTo: self.innerView.bottomAnchor, constant: -8.0).isActive = true
        self.button[11].bottomAnchor.constraint(equalTo: self.innerView.bottomAnchor, constant: -8.0).isActive = true
        
        self.button.enumerated().forEach {
            guard $0 != 0, $0 < 10 else { return }
            $1.widthAnchor.constraint(equalTo: self.button[0].widthAnchor).isActive = true
            $1.heightAnchor.constraint(equalTo: self.button[0].heightAnchor).isActive = true
        }
    }
    
    internal func updateState() {
        
        if ((!( self.textInput?.hasText ?? false )) && ( self.button[11].isEnabled )) {
            (self.button[11] as! NumPad.NumPadBackspaceButton).timer?.invalidate()
            (self.button[11] as! NumPad.NumPadBackspaceButton).timer = nil
        }
        
        self.button[11].isEnabled = self.currencyField?.clearButtonMode != .never && self.currencyField?.value?.rawValue == 0 ? true : abs( self.currencyField?.value?.rawValue ?? 0 ) != 0
        self.button[10].isEnabled = self.allowSignChange ? ( abs( self.currencyField?.value?.rawValue ?? 0 ) != 0 ) : false
    }
        
    internal func buttonHandler(_ tag: Int) {
        
        if ( self.enableInputClicksWhenVisible ) {
            UIDevice.current.playInputClick()
        }
        
        switch tag {
        case let (x) where x < 10:
            self.currencyField?.pressNumber(number: tag)
            
        case 10: // Type variadic function key
            self.currencyField?.pressSignToggle()
            
        case 11: // Backspace
            self.currencyField?.pressBackspace()
            
        default:
            break
        }
        
        self.updateState()
    }
    
}
