//
//  UIApplication.swift
//  CommonKit
//
//  Created by Oskari Rauta on 12.03.20.
//

import UIKit

public extension UIApplication {

    /// SwifterSwift: Application running environment.
    ///
    /// - debug: Application is running in debug mode.
    /// - testFlight: Application is installed from Test Flight.
    /// - appStore: Application is installed from the App Store.
    enum Environment {
        /// SwifterSwift: Application is running in debug mode.
        case debug
        /// SwifterSwift: Application is installed from Test Flight.
        case testFlight
        /// SwifterSwift: Application is installed from the App Store.
        case appStore
    }

    /// SwifterSwift: Current inferred app environment.
    var inferredEnvironment: Environment {
        get {
            #if DEBUG
            return .debug

            #elseif targetEnvironment(simulator)
            return .debug

            #else
            if Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") != nil {
                return .testFlight
            }

            guard let appStoreReceiptUrl = Bundle.main.appStoreReceiptURL else {
                return .debug
            }

            if appStoreReceiptUrl.lastPathComponent.lowercased() == "sandboxreceipt" {
                return .testFlight
            }

            if appStoreReceiptUrl.path.lowercased().contains("simulator") {
                return .debug
            }

            return .appStore
            #endif
        }
    }
    
    /// SwifterSwift: Application name (if applicable).
    var displayName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }

    /// SwifterSwift: App current build number (if applicable).
    var buildNumber: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

    /// SwifterSwift: App's current version number (if applicable).
    var version: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    var buildDate: Date? {
        guard
            let infoPath: String = Bundle.main.path(forResource: "Info.plist", ofType: nil),
            FileManager.default.fileExists(atPath: infoPath),
            let infoAttr: [FileAttributeKey: Any] = try? FileManager.default.attributesOfItem(atPath: infoPath),
            let infoDate: Date = infoAttr[.creationDate] as? Date
            else { return nil }
        return infoDate
    }
    
}
