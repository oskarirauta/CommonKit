//
//  FileManager.swift
//  CommonKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension FileManager {
    
    public func pathIsSymbolicLink(_ path: String) -> Bool {
        guard let
            attrs = try? attributesOfItem(atPath: path),
            let fileType = attrs[FileAttributeKey.type] as? FileAttributeType,
            fileType == FileAttributeType.typeSymbolicLink
            else { return false }        
        return true
    }
}
