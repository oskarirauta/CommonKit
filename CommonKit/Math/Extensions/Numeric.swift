//
//  Numeric.swift
//  MathKit
//
//  Created by Oskari Rauta on 24/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension Numeric {
    
    private func _precision(number: NSNumber, precision: Int, roundingMode: NumberFormatter.RoundingMode) -> Self? {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = precision
        formatter.roundingMode = roundingMode
        if let formatedNumString = formatter.string(from: number), let formatedNum = formatter.number(from: formatedNumString) {
            return formatedNum as? Self
        }
        return nil
        
    }
    
    public func precision(_ number: Int, roundingMode: NumberFormatter.RoundingMode = NumberFormatter.RoundingMode.halfUp) -> Self? {
        
        if let num = self as? NSNumber {
            return _precision(number: num, precision: number, roundingMode: roundingMode)
        }
        if let string = self as? String, let double = Double(string) {
            return _precision(number: NSNumber(value: double), precision: number, roundingMode: roundingMode)
        }
        return nil
    }
    
}
