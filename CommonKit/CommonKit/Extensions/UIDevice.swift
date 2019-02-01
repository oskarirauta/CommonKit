//
//  UIDevice.swift
//  CommonKit
//
//  Created by Oskari Rauta on 09/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension UIDevice {
    
    public enum DebugModeEnum {
        case notDetermined
        case production
        case development
    }
    
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

    public static var inDebugMode: UIDevice.DebugModeEnum {
        get {
            guard
                !UIDevice.isSimulator,
                let filePath: String = Bundle.main.path(forResource: "embedded", ofType: "mobileprivision"),
                FileManager.default.fileExists(atPath: filePath),
                let url: URL = URL(fileURLWithPath: filePath) as URL?,
                let data: Data = try? Data(contentsOf: url),
                let content: String = String(data: data, encoding: .ascii)
                else { return .notDetermined }
            return content.contains("<key>aps-environment</key>\n\t\t<string>development</string>") ? .development : .production
        }
    }

    public var machine: String? {
        get { return UIDevice.machine }
    }

    public var isSimulator: Bool {
        get { return UIDevice.isSimulator }
    }

    public var inDebugMode: UIDevice.DebugModeEnum {
        get { return UIDevice.inDebugMode }
    }
    
}
