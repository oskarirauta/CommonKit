//
//  CartMutatorSummary.swift
//  CommonKit
//
//  Created by Oskari Rauta on 09/09/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public struct CartMutatorSummary: Codable {
    
    public var name: String?
    public var VAT: Money
    public var totalVAT0: Money
    public var total: Money
    
    internal var _percentage: Decimal
    
    public var percentage: Decimal {
        get { return self._percentage.rounded(to: 1) }
        set { self._percentage = newValue.rounded(to: 1) }
    }
    
    public init(cart: Cart, mutator: CartMutator) {
        let mutatedCart: Cart = cart.mutated(by: mutator)
        self.name = mutator.name
        self._percentage = mutator.percentage.rounded(to: 1)
        self.VAT = -(cart.VAT - mutatedCart.VAT)
        self.totalVAT0 =  -(cart.totalVAT0 - mutatedCart.totalVAT0)
        self.total = -(cart.total - mutatedCart.total)
    }
}


public extension Array where Element == CartItem {
    
    public func mutatorSummary(for mutator: CartMutator) -> CartMutatorSummary {
        return CartMutatorSummary(cart: self, mutator: mutator)
    }
    
    public func mutatorSummary(for mutators: [CartMutator]) -> [CartMutatorSummary] {
        var _cart: Cart = self
        var summaries: [CartMutatorSummary] = [CartMutatorSummary]()
        mutators.forEach {
            summaries.append(_cart.mutatorSummary(for: $0))
            _cart = _cart.mutated(by: $0)
        }
        return summaries
    }

}

public extension Array where Element == CartMutatorSummary {
    
    public var VAT: Money {
        get {
            var _VAT: Money = Money(0)
            self.forEach { _VAT += $0.VAT }
            return _VAT
        }
    }
    
    public var totalVAT0: Money {
        get {
            var _totalVAT0: Money = Money(0)
            self.forEach { _totalVAT0 += $0.totalVAT0 }
            return _totalVAT0
        }
    }
    
    public var total: Money {
        get {
            var _total: Money = Money(0)
            self.forEach { _total += $0.total }
            return _total
        }
    }
   
    public var percentage: Decimal {
        get {
            var _percentage: Decimal = Decimal(0)
            self.forEach { _percentage += $0.percentage }
            return _percentage.rounded(to: 1)
        }
    }
    
    static public func + (lhs: [CartMutatorSummary], rhs: [CartMutatorSummary]) -> [CartMutatorSummary] {
        var _summaryArray: [CartMutatorSummary] = lhs
        _summaryArray.append(from: rhs)
        return _summaryArray
    }
    
    static public func += (lhs: inout [CartMutatorSummary], rhs: [CartMutatorSummary]) {
        lhs.append(from: rhs)
    }
    
    static public func + (lhs: [CartMutatorSummary], rhs: CartMutatorSummary) -> [CartMutatorSummary] {
        var _summaryArray: [CartMutatorSummary] = lhs
        _summaryArray.append(rhs)
        return _summaryArray
    }
    
    static public func += (lhs: inout [CartMutatorSummary], rhs: CartMutatorSummary) {
        lhs.append(rhs)
    }

}
