//
//  Data.swift
//  CommonKit
//
//  Created by Oskari Rauta on 06/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension Data {
    
    public var bytes: [UInt8] {
        get { return [UInt8](self) }
    }
    
    public func string(encoding: String.Encoding = .utf8 ) -> String? {
        return String(data: self, encoding: encoding)
    }
    
}
