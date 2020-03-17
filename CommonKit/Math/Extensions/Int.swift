//
//  Int.swift
//  MathKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension Int {
    
    var zeroNil: Int? {
        return self == 0 ? nil : self
    }

    var lastDigit: Int {
        return self == 0 ? 0 : self % 10
    }
    
    var lastTwoDigits: Int {
        return self == 0 ? 0 : self % 100
    }
    
    var string: String {
        return String(self)
    }
    
    var isOdd: Bool {
        return self % 2 == 0 ? true : false
    }
    
    var isEven: Bool {
        return self % 2 == 0 ? false : true
    }
    
    var dividedByTen: Int {
        return Int(Double(self) * 0.1)
    }
    
    var numberOfDigits: Int {
        return abs(self) < 10 ? 1 : 1 + self.dividedByTen.numberOfDigits
    }
    
    func toStr() -> String {
        return NumberFormatter.create {
            $0.numberStyle = .none
            $0.locale = Locale.appLocale
            }.string(from: NSNumber(value: self))!
    }
    
    static func random(lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
 
}
