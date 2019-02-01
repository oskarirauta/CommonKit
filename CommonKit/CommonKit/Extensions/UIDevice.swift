//
//  UIDevice.swift
//  CommonKit
//
//  Created by Oskari Rauta on 09/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension UIDevice {
    
    public static var machine: String? {
        get {
            var systemInfo = utsname()
            uname(&systemInfo)
            let modelCode = withUnsafePointer(to: &systemInfo.machine) {
                $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                    ptr in String.init(validatingUTF8: ptr)
                }
            }
            return modelCode == nil ? nil : String(validatingUTF8: modelCode!)
        }
    }

    public static var isSimulator: Bool {
        get {
            #if targetEnvironment(simulator)
            return true
            #else
            return false
            #endif
        }
    }
    
    public var machine: String? {
        get { return UIDevice.machine }
    }

    public var isSimulator: Bool {
        get { return UIDevice.isSimulator }
    }
    
}
