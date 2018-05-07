//
//  NSMutableArray.swift
//  CommonKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension NSMutableArray {

    public func rearrange(from: Int, to: Int) {
        guard from != to, from < self.count, from >= 0, to >= 0, to < self.count else { return }
        let obj: Any = self.object(at: from)
        self.removeObject(at: from)
        self.insert(obj, at: to)
    }
}
