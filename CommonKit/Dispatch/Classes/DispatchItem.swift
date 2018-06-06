//
//  DispatchItem.swift
//  DispatchKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class DispatchItem {
    
    internal var block: (DispatchItem) -> Void
    private(set) var workItem: DispatchWorkItem!
    
    public init(block: @escaping (DispatchItem) -> Void) {
        self.block = block
        self.workItem = DispatchWorkItem(block: {
            [weak self] in
            self?.block(self!)
        })
    }
    
    public init(qos: DispatchQoS, flags: DispatchWorkItemFlags, block: @escaping (DispatchItem) -> Void) {
        self.block = block
        self.workItem = DispatchWorkItem(qos: qos, flags: flags, block: {
            [weak self] in
            self?.block(self!)
        })
    }
    
    open var isCancelled: Bool {
        get { return self.workItem.isCancelled }
    }
    
    open func cancel() {
        self.workItem.cancel()
    }
    
    open func notify(qos: DispatchQoS, flags: DispatchWorkItemFlags, queue: DispatchQueue, execute: @escaping () -> Void) {
        self.workItem.notify(qos: qos, flags: flags, queue: queue, execute: execute)
    }
    
    open func notify(qos: DispatchQoS, flags: DispatchWorkItemFlags, queue: DispatchQueue, execute: @escaping (DispatchItem) -> Void) {
        self.workItem.notify(qos: qos, flags: flags, queue: queue, execute: {
            [weak self] in
            execute(self!)
        })
    }
    
    open func notify(queue: DispatchQueue, execute: DispatchWorkItem) {
        self.workItem.notify(queue: queue, execute: execute)
    }
    
    open func notify(queue: DispatchQueue, execute: DispatchItem) {
        self.workItem.notify(queue: queue, execute: execute.workItem)
    }
    
    open func perform() {
        self.workItem.perform()
    }
    
    open func wait() {
        self.workItem.wait()
    }
    
    open func wait(timeout: DispatchTime) -> DispatchTimeoutResult {
        return self.workItem.wait(timeout: timeout)
    }
    
    open func wait(wallTimeout: DispatchWallTime) -> DispatchTimeoutResult {
        return self.workItem.wait(wallTimeout: wallTimeout)
    }
    
}
