//
//  val2str.swift
//  LocaleKit
//
//  Created by Oskari Rauta on 22/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public func val2str(_ value: Int) -> String {
    let nf : NumberFormatter = NumberFormatter()
    nf.numberStyle = .none
    nf.locale = Locale.appLocale
    return nf.string(from: NSNumber(value: value as Int))!
}

public func val2str(_ value: CGFloat) -> String {
    let nf : NumberFormatter = NumberFormatter()
    let value2 : Float = Float(value)
    nf.numberStyle = .decimal
    nf.locale = Locale.appLocale
    return nf.string(from: NSNumber(value: value2 as Float))!
}

public func val2str(_ value: CGFloat, withDecimal decimalBool: Bool) -> String {
    let nf : NumberFormatter = NumberFormatter()
    let value2 : Float = Float(value)
    nf.numberStyle = .decimal
    nf.locale = Locale.appLocale
    return ( decimalBool == true && floor(value2) == value2 && value2 != 0.0) ? nf.string(from: NSNumber(value: value2 as Float))! + nf.decimalSeparator! + "0" : nf.string(from: NSNumber(value: value2 as Float))!
}

public func val2str(_ value: Float) -> String {
    let nf : NumberFormatter = NumberFormatter()
    nf.numberStyle = .decimal
    nf.locale = Locale.appLocale
    return nf.string(from: NSNumber(value: value as Float))!
}

public func val2str(_ value: Float, withDecimal decimalBool: Bool) -> String {
    let nf : NumberFormatter = NumberFormatter()
    nf.numberStyle = .decimal
    nf.locale = Locale.appLocale
    return ( decimalBool == true && floor(value) == value && value != 0.0 ) ? nf.string(from: NSNumber(value: value as Float))! + nf.decimalSeparator! + "0" : nf.string(from: NSNumber(value: value as Float))!
}

public func val2str(_ value: Double) -> String {
    let nf : NumberFormatter = NumberFormatter()
    nf.numberStyle = .decimal
    nf.locale = Locale.appLocale
    return nf.string(from: NSNumber(value: value as Double))!
}

public func val2str(_ value: Double, withDecimal decimalBool: Bool) -> String {
    let nf : NumberFormatter = NumberFormatter()
    nf.numberStyle = .decimal
    nf.locale = Locale.appLocale
    return ( decimalBool == true && floor(value) == value && value != 0.0 ) ? nf.string(from: NSNumber(value: value as Double))! + nf.decimalSeparator! + "0" : nf.string(from: NSNumber(value: value as Double))!
}

public func val2str(_ value: Decimal) -> String {
    let nf : NumberFormatter = NumberFormatter()
    nf.numberStyle = .decimal
    nf.locale = Locale.appLocale
    return nf.string(from: value.nsdecimalnumberValue)!
}

public func val2str(_ value: Decimal, withDecimal decimalBool: Bool) -> String {
    let nf : NumberFormatter = NumberFormatter()
    nf.numberStyle = .decimal
    nf.locale = Locale.appLocale
    return ( decimalBool && value.floor() == value && value != 0 ) ? nf.string(from: value.nsdecimalnumberValue)! + nf.decimalSeparator! + "0" : nf.string(from: value.nsdecimalnumberValue)!
}
