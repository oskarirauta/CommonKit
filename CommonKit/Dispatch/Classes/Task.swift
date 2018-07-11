//
//  BackgroundTask.swift
//  DispatchKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class Task: TaskBaseProtocol, TaskProtocol, NSCopying {
    
    internal var block: TaskBlock
    open private(set) var workItem: DispatchWorkItem!
    
    open var pid: Int?
    open private(set) var taskScheduler: TaskScheduler?    
    
    private(set) var completed: TaskBlock? = nil
    open var isCancelled: Bool { get { return self.workItem.isCancelled }}

    open var result: Any? = nil
    
    public required init(
        _ pid: Int? = nil,
        taskScheduler: TaskScheduler,
        block: @escaping TaskBlock,
        completed: TaskBlock? = nil
        ) {

        self.pid = pid
        self.taskScheduler = taskScheduler
        self.block = block
        self.completed = completed
        self.workItem = DispatchWorkItem(block: {
            [weak self] in
            self?.result = nil
            self?.block(self!)
            self?.finishTask()
        })
    }

    open func finishTask() {
        DispatchQueue.main.async {
            self.taskScheduler?.finishTask(self)
        }
    }
    
    open func cancel() {
        self.workItem.cancel()
    }
    
    open func perform() {
        self.workItem.perform()
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        let copy: Task = Task(self.pid, taskScheduler: self.taskScheduler!, block: self.block, completed: self.completed)
        return copy
    }

    internal func override(block: @escaping TaskBlock, completed: TaskBlock? = nil) {
        self.block = block
        self.completed = completed
        self.workItem = DispatchWorkItem(block: {
            [weak self] in
            self?.result = nil
            self?.block(self!)
            self?.finishTask()
        })
    }
    
}
