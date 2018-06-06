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
}
