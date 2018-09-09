//
//  CartMutator.swift
//  CommonKit
//
//  Created by Oskari Rauta on 06/09/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public struct CartMutator: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral, SignedNumeric, RawRepresentable, CustomStringConvertible, Equatable, Comparable, Encodable, Decodable {
    
    public typealias RawValue = Decimal
    public typealias Magnitude = Decimal
    public typealias IntegerLiteralType = Int
    public typealias FloatLiteralType = Double

    public var name: String? = nil
    
    public var percentage: Decimal {
        get { return self._rawValue.rounded(to: 1) }
        set { self._rawValue = newValue.rounded(to: 1) }
    }

    public static func + (lhs: CartMutator, rhs: CartMutator) -> CartMutator {
        return CartMutator(rawValue: lhs.rawValue + rhs.rawValue)!
    }

    public static func - (lhs: CartMutator, rhs: CartMutator) -> CartMutator {
        return CartMutator(rawValue: lhs.rawValue - rhs.rawValue)!
    }
    
    public static func * (lhs: CartMutator, rhs: CartMutator) -> CartMutator {
        return CartMutator(rawValue: lhs.rawValue * rhs.rawValue)!
    }
    
    public static func += (lhs: inout CartMutator, rhs: CartMutator) {
        lhs.rawValue += rhs.rawValue
    }
    
    public static func -= (lhs: inout CartMutator, rhs: CartMutator) {
        lhs.rawValue -= rhs.rawValue
    }
    
    public static func *= (lhs: inout CartMutator, rhs: CartMutator) {
        lhs.rawValue *= rhs.rawValue
    }
    
    public static func < (lhs: CartMutator, rhs: CartMutator) -> Bool {
        return lhs.percentage < rhs.percentage
    }
    
    public var magnitude: Decimal {
        get { return abs(self.rawValue) }
    }
    
    internal var _rawValue: Decimal

    public var description: String {
        get { return self.percentage.description }
    }
    
    public var rawValue: Decimal {
        get { return self._rawValue.rounded(to: 1) }
        set { self._rawValue = newValue.rounded(to: 1) }
    }
    
    public init(name: String? = nil, percentage: Decimal = Decimal(0)) {
        self.name = name
        self._rawValue = percentage.rounded(to: 1)
    }
    
    public init?(rawValue: Decimal) {
        self._rawValue = rawValue.rounded(to: 1)
    }

    public init?<T>(exactly source: T) where T : BinaryInteger {
        self._rawValue = (source as! Decimal).rounded(to: 1)
    }

    public init(floatLiteral value: Double) {
        self._rawValue = Decimal(value).rounded(to: 1)
    }

    public init(integerLiteral value: Int) {
        self._rawValue = Decimal(value).rounded(to: 1)
    }
    
    public init(_ value: Int) {
        self._rawValue = Decimal(value).rounded(to: 1)
    }
    
    public init(_ value: Float) {
        self._rawValue = Decimal(Double(value).rounded(to: 1))
    }
    
    public init(_ value: CGFloat) {
        self._rawValue = Decimal(Double(value).rounded(to: 1))
    }
    
    public init(_ value: Double) {
        self._rawValue = Decimal(value.rounded(to: 1))
    }
    
    public init(_ value: Decimal) {
        self._rawValue = value.rounded(to: 1)
    }
    
    public init(_ value: Money) {
        self._rawValue = value._rawValue.rounded(to: 1)
    }
    
    public init(_ value: MutatorCompatible) {
        self._rawValue = value.percentage.rounded(to: 1)
    }

}

public extension Array where Element == CartMutator {

    static public func + (lhs: [CartMutator], rhs: [CartMutator]) -> [CartMutator] {
        var _mutatorArray: [CartMutator] = lhs
        _mutatorArray.append(from: rhs)
        return _mutatorArray
    }
    
    static public func += (lhs: inout [CartMutator], rhs: [CartMutator]) {
        lhs.append(from: rhs)
    }
    
    static public func + (lhs: [CartMutator], rhs: CartMutator) -> [CartMutator] {
        var _mutatorArray: [CartMutator] = lhs
        _mutatorArray.append(rhs)
        return _mutatorArray
    }
    
    static public func += (lhs: inout [CartMutator], rhs: CartMutator) {
        lhs.append(rhs)
    }

}
