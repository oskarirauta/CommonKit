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
        set { self._count = newValue.rounded(to: 2) > 0 ? newValue.rounded(to: 2) : Decimal(floatLiteral: 0.0) }
    }
    public var unit: String? = nil
    public var price: Money
    public var VAT_percent: Decimal {
        get { return ( self._vat_percent ?? Decimal(floatLiteral: 0.0)).rounded(to: 1) }
        set { self._vat_percent = newValue < 0 ? nil : ( newValue.rounded(to: 1) > 0 ? newValue.rounded(to: 1) : Decimal(floatLiteral: 0.0)) }
    }

    internal var _count: Decimal = Decimal(floatLiteral: 1.0)
    internal var _vat_percent: Decimal? = Decimal(floatLiteral: 0.0)
    
    public var totalVAT0: Money { get { return Money((self.price.rawValue * self._count).rounded(to: 2)) }}

    public var total: Money { get { return Money(((( self.price.rawValue * ( self.VAT_percent * 0.01 )) + self.price.rawValue) * self._count).rounded(to: 2)) }}
    
    public var eachVAT: Money { get { return Money(self.price.rawValue * ( self.VAT_percent * 0.01).rounded(to: 2)) }}
    
    public var VAT: Money { get { return Money((self.price.rawValue * ( self.VAT_percent * 0.01) * self._count).rounded(to: 2)) }}
    
    public var VATPercentIsNil: Bool { get { return self._vat_percent == nil ? true : false }}
    
    public var asMoney: Money { get { return self.total }}
    
    public var description: String {
        get { return self.total.description }
    }

    public init(name: String? = nil, count: Decimal = 1, unit: String? = nil, price: Money, VAT: Decimal? = nil) {
        self.name = name
        self._count = count.rounded(to: 2) > 0 ? count.rounded(to: 2) : Decimal(floatLiteral: 0.0)
        self.unit = unit
        self.price = price
        self._vat_percent = VAT == nil ? nil : ( VAT!.rounded(to: 1) > 0 ? VAT!.rounded(to: 1) : Decimal(floatLiteral: 0.0))
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

    public static func + (lhs: CartItem, rhs: CartItem) -> [CartItem] {
        return [lhs, rhs]
    }
    
    public static func create(_ creatorFunc: (inout CartItem) -> Void) -> CartItem {
        var item: CartItem = CartItem(name: nil, count: 1, unit: nil, price: Money(0.0), VAT: nil)
        creatorFunc(&item)
        return item
    }
    
    public func properties(_ modifyFunc: (inout CartItem) -> Void) -> CartItem {
        var item: CartItem = self
        modifyFunc(&item)
        return item
    }
    
}
