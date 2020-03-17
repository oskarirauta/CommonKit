//
//  LocaleEntry.swift
//  LocaleKit
//
//  Created by Oskari Rauta on 22/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public typealias LocaleEntry = (countryCode: String, countryName: String, currencyCode: String)

extension Array where Element == LocaleEntry {
    
    public var codes: [String] {
        return self.map { $0.countryCode }
    }

    public var names: [String] {
        return self.map { $0.countryName }
    }
    
    public var currencies: [String] {
        return self.map { $0.currencyCode }
    }
}
