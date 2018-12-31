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
    get { return UIApplication.shared.delegate!.appName }
}

public var appVersion: String {
    get { return UIApplication.shared.delegate!.appVersion }
}

public var appBuildVersion: String {
    get { return UIApplication.shared.delegate!.appBuildVersion }
}

public var appBuildDate: Date? {
    get { return UIApplication.shared.delegate!.appBuildDate }
}
