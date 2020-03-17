//
//  Double.swift
//  MathKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension Double {
        
    var wholePart: Int { return Int(self) }
    
    var fractionPart: Double { return self - Double(Int(self)) }

    var fractionPart2: Int? {
        let ret: Int = Int(String(abs(self).truncatingRemainder(dividingBy: 1)).substring(from: 2)) ?? 0
        return ret == 0 ? nil : ( self < 0 ? -ret : ret )
    }

    var fractionInt: Int {
        guard self != 0 else { return 0 }
        return self == 0 ? 0 : ( self < 0 ? -Int(String(abs(self.fractionPart)).substring(from: 2))! : Int(String(abs(self.fractionPart)).substring(from: 2))!)
    }
    
    static func random(lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }

    func toStr(_ forcedDecimal: Bool = false) -> String {
        let nf: NumberFormatter = NumberFormatter.create {
            $0.numberStyle = .decimal
            $0.locale = Locale.appLocale
        }
        
        return (( forcedDecimal ) && ( floor(self) == self ) && ( self != 0 )) ? ( nf.string(from: NSNumber(value: self))! + nf.decimalSeparator! + "0" ) : nf.string(from: NSNumber(value: self))!
    }
    
    func rounded(to scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Double {
        return Decimal(self).rounded(to: scale, mode: mode).doubleValue
    }
    
}
