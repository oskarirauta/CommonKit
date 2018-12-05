//
//  UITextInput.swift
//  CommonKit
//
//  Created by Oskari Rauta on 05/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension UITextInput {
    
    public var selectedRange: NSRange? {
        guard let range = self.selectedTextRange else { return nil }
        return NSRange(location: offset(from: self.beginningOfDocument, to: range.start), length: offset(from: range.start, to: range.end))
    }
}
