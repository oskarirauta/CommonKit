//
//  Money.swift
//  CurrencyKit
//
//  Created by Oskari Rauta on 23/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public struct Money: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral, SignedNumeric, RawRepresentable, CustomStringConvertible, Comparable, Equatable, Codable, MoneyCompatible {
    
    public typealias FloatLiteralType = Double
    public typealias IntegerLiteralType = Int
    public typealias Magnitude = Decimal
    public typealias RawValue = Decimal
    
    internal var _rawValue: Decimal
    
    public var rawValue: Decimal {
        get { return self._rawValue.rounded(to: 2) }
        set { self._rawValue = newValue.rounded(to: 2) }
    }
    
    public var asMoney: Money { get { return self }}
    
    public var locale: Locale = Locale.appLocale
    
    public var doubleValue: Double { get { return self.rawValue.doubleValue }}
    public var stringValue: String { get { return self.rawValue.description }}
    public var nsnumber: NSNumber { get { return NSNumber(value: self.rawValue.doubleValue.rounded(to: 2)) }}
    public var isNegative: Bool { get { return self.rawValue < 0 }}
    public var isSignMinus: Bool { get { return self.rawValue.isSignMinus }}
    
    public var description: String { get { return self.locale.currencyFormatter.string(from: self.nsnumber)! }}
    
    public var magnitude: Decimal { get { return abs(self.rawValue) }}
    
    public static var zero: Money {
        get { return Money(0) }}
    
    enum CodingKeys: String, CodingKey {
        case _rawValue = "rawValue"
    }
    
    public init(rawValue: Decimal) {
        self._rawValue = rawValue.rounded(to: 2)
    }
    
    public init?<T>(exactly source: T) where T : BinaryInteger {
        self._rawValue = (source as! Decimal).rounded(to: 2)
    }
    
    public init(floatLiteral value: Double) {
        self._rawValue = Decimal(value).rounded(to: 2)
    }
    
    public init(integerLiteral value: Int) {
        self._rawValue = Decimal(value)
    }
    
    public init(_ value: Int) {
        self._rawValue = Decimal(value).rounded(to: 2)
    }

    public init(_ value: Float) {
        self._rawValue = Decimal(Double(value).rounded(to: 2))
    }
    
    public init(_ value: CGFloat) {
        self._rawValue = Decimal(Double(value).rounded(to: 2))
    }

    public init(_ value: Double) {
        self._rawValue = Decimal(value.rounded(to: 2))
    }
    
    public init(_ value: Decimal) {
        self._rawValue = value.rounded(to: 2)
    }
    
    public init(_ value: Money) {
        self._rawValue = value._rawValue.rounded(to: 2)
    }
    
    public init(_ value: MoneyCompatible) {
        self._rawValue = value.asMoney._rawValue.rounded(to: 2)
    }
    
    public static func * (lhs: Money, rhs: Money) -> Money {
        return Money(rawValue: lhs.rawValue * rhs.rawValue)
    }
    
    public static func *= (lhs: inout Money, rhs: Money) {
        lhs.rawValue = lhs.rawValue * rhs.rawValue
    }
    
    public static func + (lhs: Money, rhs: Money) -> Money {
        return Money(rawValue: lhs.rawValue + rhs.rawValue)
    }
    
    public static func += (lhs: inout Money, rhs: Money) {
        lhs.rawValue = lhs.rawValue + rhs.rawValue
    }
    
    public static func - (lhs: Money, rhs: Money) -> Money {
        return Money(rawValue: lhs.rawValue - rhs.rawValue)
    }
    
    public static func -= (lhs: inout Money, rhs: Money) {
        lhs.rawValue = lhs.rawValue - rhs.rawValue
    }

    public static func < (lhs: Money, rhs: Money) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    public func mutated(by percentage: Decimal) -> Money {
        return self.rawValue.mutated(by: percentage).asMoney
    }
    
    public func with(locale: Locale) -> Money {
        var _money: Money = self
        _money.locale = locale
        return _money
    }
    
}
