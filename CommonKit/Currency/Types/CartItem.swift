//
//  CartItem.swift
//  CurrencyKit
//
//  Created by Oskari Rauta on 31/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public struct CartItem: CartCompatible, Codable {
    
    public var name: String? = nil
    public var count: Decimal {
        get { return self._count }
        set { self._count = newValue.rounded(to: 2) > 0 ? newValue.rounded(to: 2) : Decimal(0) }
    }
    public var unit: String? = nil
    public var price: Money
    public var VAT_percent: Decimal {
        get { return self._vat_percent.rounded(to: 1) }
        set { self._vat_percent = newValue.rounded(to: 1) > 0 ? newValue.rounded(to: 1) : Decimal(0) }
    }

    internal var _count: Decimal = 1
    internal var _vat_percent: Decimal = Decimal(floatLiteral: 0)
    
    public var totalVAT0: Money { get { return Money((self.price.rawValue * self._count).rounded(to: 2)) }}

    public var total: Money { get { return Money(((( self.price.rawValue * ( self.VAT_percent * 0.01 )) + self.price.rawValue) * self._count).rounded(to: 2)) }}
    
    public var eachVAT: Money { get { return Money(self.price.rawValue * ( self.VAT_percent * 0.01).rounded(to: 2)) }}
    
    public var VAT: Money { get { return Money((self.price.rawValue * ( self.VAT_percent * 0.01) * self._count).rounded(to: 2)) }}
    
    public var asMoney: Money { get { return self.total }}
    
    public var description: String {
        get { return self.total.description }
    }

    public init(name: String? = nil, count: Decimal = 1, unit: String? = nil, price: Money, VAT: Decimal = Decimal(0)) {
        self.name = name
        self._count = count.rounded(to: 2) > 0 ? count.rounded(to: 2) : Decimal(0)
        self.unit = unit
        self.price = price
        self._vat_percent = VAT.rounded(to: 1) > 0 ? VAT.rounded(to: 1) : Decimal(0)
    }

    public func mutated(by percentage: Decimal) -> CartItem {
        return CartItem(name: self.name, count: self.count, unit: self.unit, price: self.price.mutated(by: percentage), VAT: self.VAT_percent)
    }
    
    public func mutated(by mutator: CartMutator) -> CartItem {
        return self.mutated(by: mutator.percentage)
    }

    public func mutated(by from: [Decimal]) -> CartItem {
        var mutatedItem: CartItem = self
        from.forEach { mutatedItem = mutatedItem.mutated(by: $0) }
        return mutatedItem
    }
    
    public func mutated(by from: [CartMutator]) -> CartItem {
        var mutatedItem: CartItem = self
        from.forEach { mutatedItem = mutatedItem.mutated(by: $0.percentage) }
        return mutatedItem
    }

    static public func + (lhs: CartItem, rhs: CartItem) -> [CartItem] {
        return [lhs, rhs]
    }
        
}
