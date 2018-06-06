//
//  Character.swift
//  CommonKit
//
//  Created by Oskari Rauta on 21/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension Character {
    
    public var string: String {
        get { return String(self) }
    }
 
    public var isNumber: Bool {
        get { return Int(self.string) != nil }
    }

    public var isLetter: Bool {
        get { return self.string.rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil }
    }
    
    public var isLowercased: Bool {
        get { return self.string == self.string.lowercased() }
    }

    public var isUppercased: Bool {
        get { return self.string == self.string.uppercased() }
    }

    public var isWhitespace: Bool {
        get { return self.string.rangeOfCharacter(from: .whitespaces, options: .numeric, range: nil) != nil }
    }

}
