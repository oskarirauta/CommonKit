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
    
    private struct AppLocale_AssociatedKeys {
        static var _appRegionCached: String? = nil
    }

    private static var appRegionCached: String? {
        get { return objc_getAssociatedObject(self, &AppLocale_AssociatedKeys._appRegionCached) as? String }
        set { objc_setAssociatedObject(self, &AppLocale_AssociatedKeys._appRegionCached, newValue as String?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    static var appRegion: String? {
        get {
            guard Thread.isMainThread else { return self.appRegionCached }
            guard let delegate: AppLocale = UIApplication.shared.delegate as? AppLocale else {
                return nil
            }
            self.appRegionCached = delegate.regionCode ?? nil
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
            var array: [LocaleEntry] = self.availableIdentifiers.filter({ !$0.isEmpty && !Locale.appLocale.localizedString(forIdentifier: $0).isEmpty && !Locale(identifier: $0).currencyCode.isEmpty }).map {
                return (countryCode: $0, countryName: Locale.appLocale.localizedString(forIdentifier: $0)!, currencyCode: Locale(identifier: $0).currencyCode!)
            }.sorted(by: { $0.countryName.localizedCaseInsensitiveCompare($1.countryName) == ComparisonResult.orderedAscending })
            array.insert((countryCode: "", countryName: NSLocalizedString("SYSTEM_DEFAULT", comment: "System default"), currencyCode: Locale.autoupdatingCurrent.currencyCode!), at: 0)
            return array
        }
    }
    

}
