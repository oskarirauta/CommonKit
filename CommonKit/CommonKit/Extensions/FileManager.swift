//
//  FileManager.swift
//  CommonKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension FileManager {
    
    /// SwifterSwift: Read from a JSON file at a given path.
    ///
    /// - Parameters:
    ///   - path: JSON file path.
    ///   - readingOptions: JSONSerialization reading options.
    /// - Returns: Optional dictionary.
    /// - Throws: Throws any errors thrown by Data creation or JSON serialization.
    func jsonFromFile(
        atPath path: String,
        readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any]? {

        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)

        return json as? [String: Any]
    }
    
    func pathIsSymbolicLink(_ path: String) -> Bool {
        guard let
            attrs = try? attributesOfItem(atPath: path),
            let fileType = attrs[FileAttributeKey.type] as? FileAttributeType,
            fileType == FileAttributeType.typeSymbolicLink
            else { return false }        
        return true
    }
    
    /// SwifterSwift: Creates a unique directory for saving temporary files. The directory can be used to create multiple temporary files used for a common purpose.
    ///
    ///     let tempDirectory = try fileManager.createTemporaryDirectory()
    ///     let tempFile1URL = tempDirectory.appendingPathComponent(ProcessInfo().globallyUniqueString)
    ///     let tempFile2URL = tempDirectory.appendingPathComponent(ProcessInfo().globallyUniqueString)
    ///
    /// - Returns: A URL to a new directory for saving temporary files.
    /// - Throws: An error if a temporary directory cannot be found or created.
    func createTemporaryDirectory() throws -> URL {
        #if !os(Linux)
        let temporaryDirectoryURL: URL
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            temporaryDirectoryURL = temporaryDirectory
        } else {
            temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        }
        return try url(for: .itemReplacementDirectory,
                       in: .userDomainMask,
                       appropriateFor: temporaryDirectoryURL,
                       create: true)
        #else
        let envs = ProcessInfo.processInfo.environment
        let env = envs["TMPDIR"] ?? envs["TEMP"] ?? envs["TMP"] ?? "/tmp"
        let dir = "/\(env)/file-temp.XXXXXX"
        var template = [UInt8](dir.utf8).map({ Int8($0) }) + [Int8(0)]
        guard mkdtemp(&template) != nil else { throw CocoaError.error(.featureUnsupported) }
        return URL(fileURLWithPath: String(cString: template))
        #endif
    }
}
