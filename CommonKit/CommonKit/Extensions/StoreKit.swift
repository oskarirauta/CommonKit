//
//  StoreKit.swift
//  CommonKit
//
//  Created by Oskari Rauta on 12.03.20.
//

#if canImport(StoreKit)
import StoreKit

public extension SKProduct {

    private static let priceFormatter: NumberFormatter = {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency
        return priceFormatter
    }()

    /// SwifterSwift: Localized price of SKProduct
    var localizedPrice: String? {
        let formatter = SKProduct.priceFormatter
        formatter.locale = priceLocale
        return formatter.string(from: price)
    }

}
#endif
