//
//  LocaleEntry.swift
//  LocaleKit
//
//  Created by Oskari Rauta on 22/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public typealias LocaleEntry = (countryCode: String, countryName: String)

extension Array where Element == LocaleEntry {
    
    public var codes: Array<String> {
        get { return self.map { $0.countryCode }}
    }

    public var names: Array<String> {
        get { return self.map { $0.countryName }}
    }    
}
