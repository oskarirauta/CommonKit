//
//  Dictionary.swift
//  CommonKit
//
//  Created by Oskari Rauta on 06/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    func has(key: Key) -> Bool {
        return self.index(forKey: key) != nil
    }
    
    func jsonData(prettyPrinted: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: self, options: prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions())
    }
    
    func jsonString(prettyPrinted: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
    
}
