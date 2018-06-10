//
//  CommonFuncs.swift
//  CommonKit
//
//  Created by Oskari Rauta on 29/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public var isIpad: Bool {
    get { return UIDevice.current.model.range(of: "iPad") != nil ? true : false }
}

public var newUUID: String {
    get { return UUID().uuidString }
}

public func doNothing() {}

public var appName: String {
    get { return Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as! String }
}

public var appVersion: String {
    get { return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String }
}

public var appBuildVersion: String {
    get { return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String }
}
