//
//  Decimal.swift
//  MathKit
//
//  Created by Oskari Rauta on 24/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension Decimal {

    public init(high: Int, low: Int) {
        let s: String = String(abs(high)) + ( Locale.current.decimalSeparator ?? "." ) + String((low))
        self = Decimal(string: s, locale: Locale.current)!
    }
    
    public var intValue: Int { get { return NSDecimalNumber(decimal: self).intValue }}
    
    public var floatValue: Float { get { return NSDecimalNumber(decimal: self).floatValue }}
    
    public var doubleValue: Double { get { return NSDecimalNumber(decimal: self).doubleValue }}

    public var significantFractionalDecimalDigits: Int { return max(-exponent, 0) }

    public var wholePart: Decimal { get { return Decimal(self.intValue) }}
    public var fractionPart: Decimal { get { return self - Decimal(self.intValue) }}
    public var fractionPart2: Decimal { get { return self.distance(to: Decimal(self.intValue)) }}

    public func rounded(to scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
        // Source: https://stackoverflow.com/questions/28651848/nsdecimalround-in-swift
        // Thank you: Ruben Kazumov
        let amount: NSDecimalNumber = NSDecimalNumber(decimal: self)
        let uMPtr = UnsafeMutablePointer<Decimal>.allocate(capacity: 1)
        uMPtr[0] = amount.decimalValue
        let uPtr = UnsafePointer<Decimal>.init(uMPtr)
        NSDecimalRound(uMPtr, uPtr, scale, mode)
        return uMPtr.pointee
    }

}
