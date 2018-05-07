//
//  UIApplicationDelegate.swift
//  CommonKit
//
//  Created by Oskari Rauta on 29/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension UIApplicationDelegate {
    
    public var appName: String {
        get { return Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String }}
    
    public var appVersion: String {
        get { return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String }}
    
    public var appBuildVersion: String {
        get { return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String }}
    
}
