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
            return (Thread.isMainThread ? ( UIApplication.shared.delegate as? AppLocale ) : { DispatchQueue.main.sync { return UIApplication.shared.delegate as? AppLocale }
            }())?.regionCode ?? nil
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
    
    static var countryCodes: [String] {
        get { return self.locales.map { $0.countryCode } }
    }
    
    static var countryNames: [String] {
        get { return self.locales.map { $0.countryName } }
    }

    static var currencyCodes: [String] {
        get { return self.locales.map { $0.currencyCode } }
    }

    static var locales: [LocaleEntry] {
        get {
            var array: [LocaleEntry] = self.availableIdentifiers.filter({ !$0.isEmpty && !Locale.autoupdatingCurrent.localizedString(forIdentifier: $0).isEmpty && !Locale(identifier: $0).currencyCode.isEmpty }).map {
                return (countryCode: $0, countryName: Locale.autoupdatingCurrent.localizedString(forIdentifier: $0)!, currencyCode: Locale(identifier: $0).currencyCode!)
            }.sorted(by: { $0.countryName.localizedCaseInsensitiveCompare($1.countryName) == ComparisonResult.orderedAscending })
            array.insert((countryCode: "", countryName: NSLocalizedString("SYSTEM_DEFAULT", comment: "System default"), currencyCode: Locale.autoupdatingCurrent.currencyCode ??  Locale.autoupdatingCurrent.currencySymbol!), at: 0)
            return array
        }
    }
    
    /// SwifterSwift: Get the flag emoji for a given country region code.
    /// - Parameter isoRegionCode: The IOS region code.
    ///
    /// Adapted from https://stackoverflow.com/a/30403199/1627511
    static func flagEmoji(forRegionCode isoRegionCode: String) -> String? {
        #if !os(Linux)
        guard isoRegionCodes.contains(isoRegionCode) else { return nil }
        #endif

        return isoRegionCode.unicodeScalars.reduce(into: String()) {
            guard let flagScalar = UnicodeScalar(UInt32(127397) + $1.value) else { return }
            $0.unicodeScalars.append(flagScalar)
        }
    }
    
}
