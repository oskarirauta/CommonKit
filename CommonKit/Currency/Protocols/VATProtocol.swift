//
//  VATProtocol.swift
//  CurrencyKit
//
//  Created by Oskari Rauta on 01/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol VATProtocol {
    var VAT_percent: Decimal { get set }
    var VATPercentIsNil: Bool { get }
}
