//
//  Float.swift
//  MathKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension Float {
    
    var wholePart: Int {
        get { return Int(self) }
    }
    
    var fractionPart: Float { get { return self - Float(Int(self)) }}

    var fractionPart2: Int? {
        get {
            let ret: Int = Int(String(abs(self).truncatingRemainder(dividingBy: 1)).substring(from: 2)) ?? 0
            return ret == 0 ? nil : ( self < 0 ? -ret : ret )
        }
    }

    var fractionInt: Int { get {
        guard self != 0 else { return 0 }
        return self == 0 ? 0 : ( self < 0 ? -Int(String(abs(self.fractionPart)).substring(from: 2))! : Int(String(abs(self.fractionPart)).substring(from: 2))!)
        }}

    static func random(lower: Float = 0, _ upper: Float = 100) -> Float {
        return (Float(arc4random()) / 4294967296) * (upper - lower) + lower
    }

    func toStr(_ forcedDecimal: Bool = false) -> String {
        let nf: NumberFormatter = NumberFormatter.create {
            $0.numberStyle = .decimal
            $0.locale = Locale.appLocale
        }
        
        return (( forcedDecimal ) && ( floor(self) == self ) && ( self != 0 )) ? ( nf.string(from: NSNumber(value: self))! + nf.decimalSeparator! + "0" ) : nf.string(from: NSNumber(value: self))!
    }
    
    func rounded(to scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Float {
        return Float(Decimal(Double(self)).rounded(to: scale, mode: mode).doubleValue)
    }

    
}
