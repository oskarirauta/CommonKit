//
//  BackgroundTask.swift
//  DispatchKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class Task: AbstractTaskProtocol, TaskProtocol, NSCopying {

    public private(set) var block: TaskBlock
    open private(set) var workItem: DispatchWorkItem!
    
    open var pid: Int?
    open var taskType: Int?
    open private(set) var taskScheduler: TaskSchedulerClass?
    open private(set) var isRunning: Bool

    public private(set) var completed: TaskBlock? = nil
    open var isCancelled: Bool { get { return self._isCancelled }}

    open var result: Any? = nil
    
    internal var _isCancelled: Bool
    
    public required init(
        _ pid: Int? = nil,
        taskScheduler: TaskSchedulerClass,
        block: @escaping TaskBlock,
        completed: TaskBlock? = nil,
        taskType: Int? = nil
        ) {

        self.pid = pid
        self.taskType = taskType
        self.taskScheduler = taskScheduler
        self.block = block
        self.completed = completed
        self.isRunning = false
        self._isCancelled = false
        self.workItem = DispatchWorkItem(block: {
            [weak self] in
            self?.isRunning = true
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
        self._isCancelled = true
        self.workItem.cancel()
        self.isRunning = false
    }
    
    open func perform() {
        guard !self.isCancelled else { return }
        self.isRunning = true
        self.workItem.perform()
    }

    public func copy(with zone: NSZone? = nil) -> Any {
        let copy: Task = Task(self.pid, taskScheduler: self.taskScheduler!, block: self.block, completed: self.completed, taskType: self.taskType)
        return copy
    }

    public func taskCopy() -> Task {
        return self.copy() as! Task
    }
    
    internal func override(block: @escaping TaskBlock, completed: TaskBlock? = nil, taskType: Int? = nil) {
        
        guard !self.isRunning else {
            fatalError("Overriding is only allowed while task is not running.")
        }
        
        self.block = block
        self.completed = completed
        self.taskType = taskType
        self.workItem = DispatchWorkItem(block: {
            [weak self] in
            self?.isRunning = true
            self?._isCancelled = false
            self?.result = nil
            self?.block(self!)
            self?.finishTask()
        })
    }
    
    public func properties(_ modifyFunc: (inout Task) -> Void) -> Task {
        var retVal: Task = self
        modifyFunc(&retVal)
        return retVal
    }

    
}
