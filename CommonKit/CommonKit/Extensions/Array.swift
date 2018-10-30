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

    @discardableResult
    public mutating func removeIndexes(at: [Int]) -> [Element] {
        var ret: [Element] = []
        at.filter { $0 < self.count }.sorted(by: { $0 > $1 }).forEach {
            ret.append(self.remove(at: $0))
        }
        return ret
    }

    @discardableResult
    public mutating func removeIndexes(at: Int...) -> [Element] {
        var ret: [Element] = []
        at.filter { $0 < self.count }.sorted(by: { $0 > $1 }).forEach {
            ret.append(self.remove(at: $0))
        }
        return ret
    }
    
    public func filterIndex(at index: Int) -> [Element] {
        return self.enumerated().filter({ $0.offset != index }).map { $0.element }
    }

    public func filterIndex(at indexes: [Int]) -> [Element] {
        return self.enumerated().filter({ !indexes.contains($0.offset) }).map { $0.element }
    }
    
}

extension Optional: IsEmptyProtocol where Wrapped: Collection {
    
    public var isEmpty: Bool {
        get { return self?.isEmpty ?? true }}
    
}
