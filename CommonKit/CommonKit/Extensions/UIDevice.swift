//
//  UIDevice.swift
//  CommonKit
//
//  Created by Oskari Rauta on 09/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension UIDevice {
    
    enum DeviceFamilyEnum {
        
        case iphone
        case ipod
        case ipad
        case watch
        case tvos
        case macCatalyst
        case osx
        case carplay
        case unknown
        
        public var description: String {
            get {
                switch self {
                case .iphone: return "iPhone"
                case .ipod: return "iPod"
                case .ipad: return "iPad"
                case .watch: return "Apple Watch"
                case .tvos: return "Apple TV"
                case .macCatalyst: return "Mac Catalyst"
                case .osx: return "Mac"
                case .carplay: return "Carplay"
                case .unknown: return "Unknown"
                }
            }
        }
        
        public var iphoneCompatible: Bool {
            get { return self == .iphone || self == .ipod }
        }
        
        public var ipadCompatible: Bool {
            get { return self == .ipad }
        }
        
        public var osxCompatible: Bool {
            get { return self == .macCatalyst || self == .osx }
        }
        
    }
    
    enum DebugModeEnum {
        
        case notDetermined
        case production
        case development
        
        public var description: String {
            get {
                switch self {
                case .notDetermined: return "Not determined"
                case .production: return "Product environment"
                case .development: return "Development environment"
                }
            }
        }
    }
    
    static var machine: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        return String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!
    }

    static var inSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }

    static var debugMode: UIDevice.DebugModeEnum {
        guard
            !self.inSimulator,
            let filePath: String = Bundle.main.path(forResource: "embedded", ofType: "mobileprovision"),
            FileManager.default.fileExists(atPath: filePath),
            let url: URL = URL(fileURLWithPath: filePath) as URL?,
            let data: Data = try? Data(contentsOf: url),
            let content: String = String(data: data, encoding: .ascii)
            else { return .notDetermined }
        return content.contains("<key>aps-environment</key>\n\t\t<string>development</string>") ? .development : .production
    }

    static var deviceFamily: UIDevice.DeviceFamilyEnum {
        #if targetEnvironment(macCatalyst)
        return .macCatalyst
        #elseif os(OSX)
        return .osx
        #elseif os(watchOS)
        return .watch
        #elseif os(tvOS)
        return .tvos
        #else
        switch UIDevice.current.userInterfaceIdiom {
        case .carPlay: return .carplay
        case .pad: return .ipad
        case .phone: return UIDevice.current.model.uppercased().contains("IPOD") ? .ipod : .iphone
        case .tv: return .tvos
        default: return .unknown
        }
        #endif
    }
        
}
