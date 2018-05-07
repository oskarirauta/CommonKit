//
//  AllValuesProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 18/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

public protocol EnumCollection: Hashable {
    static var allValues: [Self] { get }
}

extension EnumCollection {
    
    public static var allValues: [Self] {
        
        return [Self](AnySequence{ () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        })
    }
}
