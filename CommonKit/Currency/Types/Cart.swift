//
//  Cart.swift
//  CurrencyKit
//
//  Created by Oskari Rauta on 31/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public typealias Cart = [CartItem]

extension Array: MoneyCompatible, PriceProtocol where Element == CartItem {

    public var totalVAT0: Money { get { return Money(self.map{ $0.totalVAT0.rawValue }.reduce(0, +)) }}
    public var total: Money { get { return Money(self.map{ $0.total.rawValue }.reduce(0, +)) }}
    public var VAT: Money { get { return Money(self.map{ $0.VAT.rawValue }.reduce(0, +)) }}

    public var asMoney: Money { get { return self.total }}
    
    public func mutated(by percentage: Decimal) -> Cart {
        return self.map { $0.mutated(by: percentage) }
    }
    
    public func mutated(by mutator: CartMutator) -> Cart {
        return self.map { $0.mutated(by: mutator) }
    }
    
    public func mutated(by from: [Decimal]) -> Cart {
        return self.map { $0.mutated(by: from) }
    }
    
    public func mutated(by from: [CartMutator]) -> Cart {
        return self.map { $0.mutated(by: from) }
    }
    
    static public func + (lhs: [CartItem], rhs: [CartItem]) -> [CartItem] {
        var _cart: [CartItem] = lhs
        _cart.append(from: rhs)
        return _cart
    }
    
    static public func += (lhs: inout [CartItem], rhs: [CartItem]) {
        lhs.append(from: rhs)
    }

    static public func + (lhs: [CartItem], rhs: CartItem) -> [CartItem] {
        var _cart: [CartItem] = lhs
        _cart.append(rhs)
        return _cart
    }
    
    static public func += (lhs: inout [CartItem], rhs: CartItem) {
        lhs.append(rhs)
    }    
    
}
