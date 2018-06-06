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
        /*  This function gave wrong results when whole part was too small; so it's tweaked. Some
            values from top scale are unavailable, but Decimal should have quite a big range, so
            for most cases it's enough.
        */
        let isNegative: Bool = self < 0 ? true : false
        var decimalValue: Decimal = 119 + abs(self).fractionPart
        var result: Decimal = Decimal()
        NSDecimalRound(&result, &decimalValue, scale, mode)
        result = result + abs(self.wholePart) - 119
        return isNegative ? -result : result
    }

}
