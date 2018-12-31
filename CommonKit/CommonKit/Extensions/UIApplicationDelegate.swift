//
//  UIApplicationDelegate.swift
//  CommonKit
//
//  Created by Oskari Rauta on 29/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public extension UIApplicationDelegate {
    
    public var appName: String {
        get { return Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String }}
    
    public var appVersion: String {
        get { return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String }}
    
    public var appBuildVersion: String {
        get { return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String }}
    
    public var appBuildDate: Date? {
        get {
            guard
                let infoPath: String = Bundle.main.path(forResource: "Info.plist", ofType: nil),
                FileManager.default.fileExists(atPath: infoPath),
                let infoAttr: [FileAttributeKey: Any] = try? FileManager.default.attributesOfItem(atPath: infoPath),
                let infoDate: Date = infoAttr[.creationDate] as? Date
                else { return nil }
            return infoDate
        }
    }

}
