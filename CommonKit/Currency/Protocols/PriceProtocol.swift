//
//  PriceProtocol.swift
//  CurrencyKit
//
//  Created by Oskari Rauta on 31/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol PriceProtocol {
    var totalVAT0: Money { get }
    var total: Money { get }
    var VAT: Money { get }
}
