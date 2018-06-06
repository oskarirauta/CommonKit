//
//  Locale.swift
//  LocaleKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public extension Locale {
    
    static var appRegion: String? {
        get {
            guard let delegate: AppLocale = UIApplication.shared.delegate as? AppLocale else {
                return nil
            }
            return delegate.regionCode ?? nil
        }
    }
    
    static var appLocale: Locale {
        get {
            guard let region: String = Locale.appRegion, !region.isEmpty else {
                return Locale.autoupdatingCurrent
            }
            return Locale(identifier: region)
        }
    }
    
    static var locales: [String: String] {
        get {
            var _locales: [String: String] = [:]
            self.availableIdentifiers.filter({ !$0.isEmpty }).forEach {
                if let desc = Locale.autoupdatingCurrent.localizedString(forIdentifier: $0) {
                    _locales[$0] = desc
                }
            }
            _locales[""] = NSLocalizedString("SYSTEM_DEFAULT", comment: "System default")
            return _locales
        }
    }

    static var countryCodes: [String] {
        get { return Array(self.locales.keys) }
    }
    
    static var countryNames: [String] {
        get { return Array(self.locales.values) }
    }

    static var localeArray: [LocaleEntry] {
        get {
            var array: [LocaleEntry] = self.locales.filter({ !$0.key.isEmpty }).map {
                return (countryCode: $0.key, countryName: $0.value)
            }.sorted(by: { $0.countryName.localizedCaseInsensitiveCompare($1.countryName) == ComparisonResult.orderedAscending })
            array.insert((countryCode: "", countryName: NSLocalizedString("SYSTEM_DEFAULT", comment: "System default")), at: 0)
            return array
        }
    }
    
}
