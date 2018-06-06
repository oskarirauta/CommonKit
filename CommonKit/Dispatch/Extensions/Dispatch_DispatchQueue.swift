//
//  DispatchQueue.swift
//  DispatchKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension DispatchQueue {

    open func delay(_ delay: Double, execute: DispatchItem) {
        self.asyncAfter(deadline: .now() + delay, execute: execute.workItem)
    }

    open func async(execute: DispatchItem) {
        self.async(execute: execute.workItem)
    }
    
    open func async(group: DispatchGroup, execute: DispatchItem) {
        self.async(group: group, execute: execute.workItem)
    }
    
    open func asyncAfter(deadline: DispatchTime, execute: DispatchItem) {
        self.asyncAfter(deadline: deadline, execute: execute.workItem)
    }
    
    open func asyncAfter(wallDeadline: DispatchWallTime, execute: DispatchItem) {
        self.asyncAfter(wallDeadline: wallDeadline, execute: execute.workItem)
    }
    
    open func sync(execute: DispatchItem) {
        self.sync(execute: execute.workItem)
    }
    
}
