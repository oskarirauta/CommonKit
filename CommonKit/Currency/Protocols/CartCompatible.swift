//
//  CartCompatible.swift
//  CommonKit
//
//  Created by Oskari Rauta on 06/09/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol AbstractCartCompatible {
    var name: String? { get set }
    var count: Decimal { get set }
    var unit: String? { get set }
}

public protocol CartCompatible: MoneyCompatible, AbstractCartCompatible, PriceProtocol, VATProtocol, CustomStringConvertible {
    var price: Money { get set }
    var eachVAT: Money { get }
}
