//
//  AutoCreatable.swift
//  CommonKit
//
//  Created by Oskari Rauta on 23/08/2018.
//

import Foundation

public protocol ConditionalInit {
    mutating func conditionalInit(_ creatorFunc: ((Self) -> Void)?) -> Self
}

extension Optional:ConditionalInit where Wrapped: NSObject {
    
    @discardableResult
    public mutating func conditionalInit(_ creatorFunc: ((Optional<Wrapped>) -> Void)? = nil) -> Optional<Wrapped> {
        guard self == nil else { return self! }
        self = Wrapped.init()
        creatorFunc?(self!)
        return self!
    }
}
