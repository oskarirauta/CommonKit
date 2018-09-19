//
//  CurrencyPadButton.swift
//  CurrencyKit
//
//  Created by Oskari Rauta on 23/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension CurrencyPad {
    
    public class CurrencyFunctionButton: UIButton {
        
        public var handler: ((Int) -> Void)? = nil
        private(set) var style: NumPadStyle = .default
        
        override public var isEnabled: Bool {
            didSet { self.setTitleColor(self.isEnabled ? self.style.foregroundColor : self.style.foregroundColorHighlighted, for: .normal) }
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        public init(style: NumPadStyle = .default, handler: ((Int) -> Void)? = nil) {
            super.init(frame: .zero)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.setImage(UIImage(named: "plusminus", in: Bundle(for: CurrencyPad.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: UIControl.State())
            self.showsTouchWhenHighlighted = true
            
            self.style = style
            self.tag = 10
            self.backgroundColor = UIColor.clear
            self.tintColor = style.foregroundColor
            self.handler = handler
            self.addTarget(self, action: #selector(self.buttonDown), for: .touchDown)
        }
        
        @objc internal func buttonDown() {
            self.handler?(self.tag)
        }
    }

    
}
