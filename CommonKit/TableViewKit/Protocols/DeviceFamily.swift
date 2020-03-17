//
//  DeviceFamily.swift
//  CommonKit
//
//  Created by Oskari Rauta on 17.03.20.
//  Copyright © 2020 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol DeviceFamily {

    static var iphoneCompatible: Bool { get }
    static var ipadCompatible: Bool { get }
    static var osxCompatible: Bool { get }
    
    var iphoneCompatible: Bool { get }
    var ipadCompatible: Bool { get }
    var osxCompatible: Bool { get }
}

public extension DeviceFamily {

    static var iphoneCompatible: Bool { return UIDevice.deviceFamily.iphoneCompatible }
    static var ipadCompatible: Bool { return UIDevice.deviceFamily.ipadCompatible }
    static var osxCompatible: Bool { return UIDevice.deviceFamily.osxCompatible }

    var iphoneCompatible: Bool { return Self.iphoneCompatible }
    var ipadCompatible: Bool { return Self.ipadCompatible }
    var osxCompatible: Bool { return self.osxCompatible }
}

extension UIViewController: DeviceFamily { }
extension UIView: DeviceFamily { }
