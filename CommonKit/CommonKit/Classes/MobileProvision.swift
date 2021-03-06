//
//  MobileProvision.swift
//  CommonKit
//
//  Sourced from:
//  https://blog.process-one.net/reading-ios-provisioning-profile-in-swift/
//
//  Created by Oskari Rauta on 04.03.19.
//  Copyright © 2019 Oskari Rauta. All rights reserved.
//

import Foundation

/* Decode mobileprovision plist file
 Usage:
 
 1. To get mobileprovision data as embedded in your app:
 MobileProvision.read()
 2. To get mobile provision data from a file on disk:
 
 MobileProvision.read(from: "my.mobileprovision")
 
 */

public struct MobileProvision: Decodable {
    public var name: String
    public var appIDName: String
    public var platform: [String]
    public var isXcodeManaged: Bool? = false
    public var creationDate: Date
    public var expirationDate: Date
    public var entitlements: Entitlements
    
    private enum CodingKeys : String, CodingKey {
        case name = "Name"
        case appIDName = "AppIDName"
        case platform = "Platform"
        case isXcodeManaged = "IsXcodeManaged"
        case creationDate = "CreationDate"
        case expirationDate = "ExpirationDate"
        case entitlements = "Entitlements"
    }
    
    // Sublevel: decode entitlements informations
    public struct Entitlements: Decodable {
        public let keychainAccessGroups: [String]
        public let getTaskAllow: Bool
        public let apsEnvironment: Environment
        
        private enum CodingKeys: String, CodingKey {
            case keychainAccessGroups = "keychain-access-groups"
            case getTaskAllow = "get-task-allow"
            case apsEnvironment = "aps-environment"
        }
        
        public enum Environment: String, Decodable {
            case development, production, disabled
        }
        
        public init(keychainAccessGroups: Array<String>, getTaskAllow: Bool, apsEnvironment: Environment) {
            self.keychainAccessGroups = keychainAccessGroups
            self.getTaskAllow = getTaskAllow
            self.apsEnvironment = apsEnvironment
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let keychainAccessGroups: [String] = (try? container.decode([String].self, forKey: .keychainAccessGroups)) ?? []
            let getTaskAllow: Bool = (try? container.decode(Bool.self, forKey: .getTaskAllow)) ?? false
            let apsEnvironment: Environment = (try? container.decode(Environment.self, forKey: .apsEnvironment)) ?? .disabled
            
            self.init(keychainAccessGroups: keychainAccessGroups, getTaskAllow: getTaskAllow, apsEnvironment: apsEnvironment)
        }
    }
}

// Factory methods
public extension MobileProvision {
    // Read mobileprovision file embedded in app.
    static func read() -> MobileProvision? {
        let profilePath: String? = Bundle.main.path(forResource: "embedded", ofType: "mobileprovision")
        guard let path = profilePath else { return nil }
        return read(from: path)
    }
    
    // Read a .mobileprovision file on disk
    static func read(from profilePath: String) -> MobileProvision? {
        guard let plistDataString = try? NSString.init(contentsOfFile: profilePath,
                                                       encoding: String.Encoding.isoLatin1.rawValue) else { return nil }
        
        // Skip binary part at the start of the mobile provisionning profile
        let scanner = Scanner(string: plistDataString as String)
        
        guard let _: String = scanner.scanUpToString("<plist") else { return nil }
        
        // ... and extract plist until end of plist payload (skip the end binary part.
        var extractedPlist: NSString?

        guard let _str: String = scanner.scanUpToString("</plist>") else { return nil }
        extractedPlist = NSString(string: _str)

        guard extractedPlist != nil else { return nil }
        
        guard let plist = extractedPlist?.appending("</plist>").data(using: .isoLatin1) else { return nil }
        let decoder = PropertyListDecoder()
        do {
            let provision = try decoder.decode(MobileProvision.self, from: plist)
            return provision
        } catch {
            // TODO: log / handle error
            return nil
        }
    }
}
