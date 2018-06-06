//
//  MoneyCompatible.swift
//  CurrencyKit
//
//  Created by Oskari Rauta on 31/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol MoneyCompatible {
    var asMoney: Money { get }
}

extension CGFloat: MoneyCompatible {
    
    public var asMoney: Money { get { return Money(self) }}
}

extension Decimal: MoneyCompatible {
    
    public var asMoney: Money { get { return Money(self) }}
}

extension Double: MoneyCompatible {
    
    public var asMoney: Money { get { return Money(self) }}
}

extension Float: MoneyCompatible {
    
    public var asMoney: Money { get { return Money(self) }}
}

extension Int: MoneyCompatible {
    
    public var asMoney: Money { get { return Money(self) }}
}
