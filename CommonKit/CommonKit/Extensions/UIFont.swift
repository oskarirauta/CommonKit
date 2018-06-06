//
//  UIFont.swift
//  CommonKit
//
//  Created by Oskari Rauta on 06/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension UIFont {
    
    public var bold: UIFont {
        get { return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0) }
    }
    
    public var italic: UIFont {
        get { return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits(.traitItalic)!, size: 0) }
    }
    
}
