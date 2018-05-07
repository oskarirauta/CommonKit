//
//  Array.swift
//  CommonKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension Array {
    
    public var lastIndex: Int {
        get { return self.count - 1 }}

    public mutating func append(from: Array<Element>) {
        from.forEach { self.append($0) }
    }

    public mutating func rearrange(from: Int, to: Int) {
        guard from != to, from < self.count, from >= 0, to >= 0, to < self.count else { return }
        self.insert(self.remove(at: from), at: to)
    }

}

extension Optional: IsEmptyProtocol where Wrapped: Collection {
    
    public var isEmpty: Bool {
        get { return self?.isEmpty ?? true }}
    
}
