//
//  TaskScheduler.swift
//  DispatchKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class TaskScheduler: AbstractTaskSchedulerProtocol, TaskSchedulerProtocol {
        
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
        guard !self.processing, self.task == nil, let nextTask = self.tasks.first else {
            return self.pid
        }
        guard !nextTask.isCancelled else {
            let pid: Int? = nextTask.pid
            while let index = self.tasks.index(where: { $0.pid == pid }) {
                self.tasks.remove(at: index)
            }
            return self.executeTasks()
        }
        self.task = nextTask
        thread.async(execute: self.task!.workItem)
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
        while let index = self.tasks.index(where: { $0.pid == self.pid }) {
            self.tasks.remove(at: index)
        }
        self.task = nil
        self.executeTasks()
    }
    
}
