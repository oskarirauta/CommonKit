//
//  TextViewProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol TextViewProtocol {
    var placeHolderFont: UIFont { get set }
}

extension TextFieldProtocol where Self: UITextView {
    
    public var value: String? {
        get { return self.hasText ? self.text : nil }
        set { self.text = newValue }
    }
}
