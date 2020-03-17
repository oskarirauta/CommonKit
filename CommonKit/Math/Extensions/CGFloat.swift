//
//  CGFloat.swift
//  MathKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension CGFloat {

    var wholePart: Int {
        return Int(self)
    }
    
    var fractionPart: CGFloat {
        return self - CGFloat(Int(self))
    }

    var fractionPart2: Int? {
        let ret: Int = Int(String(abs(Float(self)).truncatingRemainder(dividingBy: 1)).substring(from: 2)) ?? 0
        return ret == 0 ? nil : ( self < 0 ? -ret : ret )
    }
    
    var fractionInt: Int {
        guard self != 0 else { return 0 }
        return self == 0 ? 0 : ( self < 0 ? -Int(String(abs(Float(self.fractionPart))).substring(from: 2))! : Int(String(abs(Float(self.fractionPart))).substring(from: 2))!)
    }

    static func random(lower: CGFloat = 0, _ upper: CGFloat = 100) -> CGFloat {
        return (CGFloat(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }

    func toStr(_ forcedDecimal: Bool = false) -> String {
        let nf: NumberFormatter = NumberFormatter.create {
            $0.numberStyle = .decimal
            $0.locale = Locale.appLocale
        }
        
        return (( forcedDecimal ) && ( floor(self) == self ) && ( self != 0 )) ? ( nf.string(from: NSNumber(value: Float(self)))! + nf.decimalSeparator! + "0" ) : nf.string(from: NSNumber(value: Float(self)))!
    }
    
}
