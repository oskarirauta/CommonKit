//
//  MultiTaskScheduler.swift
//  CommonKit
//
//  Created by Oskari Rauta on 27/09/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class MultiTaskScheduler: AbstractTaskSchedulerProtocol, TaskSchedulerProtocol {
    
    open private(set) var task: Task?
    open private(set) var nextPid: Int
    
    open private(set) var tasks: [Task]
    
    open var pid: Int? { get { return self.task?.pid }}
    open var processing: Bool { get { return self.task != nil }}
    
    public private(set) var thread: DispatchQueue
    
    public required init(thread: DispatchQueue = DispatchQueue.global(qos: .background)) {
        self.nextPid = -1
        self.task = nil
        self.tasks = []
        self.thread = thread
    }
    
    @discardableResult open func addTask(
        execute: @escaping TaskBlock,
        completed: TaskBlock? = nil,
        wait: Bool = false
        ) -> Int {
        self.nextPid = self.nextPid + 1 > 99999 ? 0 : self.nextPid + 1
        self.tasks.append(
            Task(
                self.nextPid,
                taskScheduler: self,
                block: execute,
                completed: completed
        ))
        guard !wait else { return self.nextPid }
        self.executeTasks()
        return self.nextPid
    }
    
    @discardableResult open func addTask(execute: Task, wait: Bool = false) -> Int {
        self.nextPid = self.nextPid + 1 > 99999 ? 0 : self.nextPid + 1
        execute.pid = self.nextPid
        self.tasks.append(execute.copy() as! Task)
        guard !wait else { return self.nextPid }
        self.executeTasks()
        return self.nextPid
    }
    
    @discardableResult open func executeTasks() -> Int? {
        guard !self.processing else {
            return self.pid
        }
        
        self.tasks.removeIndexes(at: self.tasks.enumerated().filter { $0.element.isCancelled }.map { $0.offset })
        
        var pid: Int? = nil
        
        self.tasks.filter { !$0.isRunning && !$0.isCancelled }.forEach {
            if ( pid == nil ) { pid = $0.pid }
            thread.async(execute: $0.workItem)
        }
        
        return self.pid
    }
    
    @discardableResult open func cancelTask(pid: Int) -> Bool {
        guard let task = self.tasks.first(where: { $0.pid == pid }), !task.isCancelled else {
            return false
        }
        task.cancel()
        return true
    }
    
    open func cancelAllTasks() {
        tasks.forEach({ $0.cancel() })
    }
    
    public func finishTask(_ task: Task) {
        
        if ( !task.isCancelled ) {
            task.completed?(task)
        }
        self.tasks.removeIndexes(at: self.tasks.enumerated().filter { $0.element.pid == pid }.map { $0.offset })
        self.task = nil
        self.executeTasks()
    }
    
}
