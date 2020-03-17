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
    open var processing: Bool { get { return self._processing }}
    
    open private(set) var thread: DispatchQueue
    internal var _processing: Bool = false

    public required init(thread: DispatchQueue = DispatchQueue.global(qos: .utility)) {
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
        self.tasks.append((execute.copy() as! Task).properties { $0.pid = self.nextPid })
        guard !wait else { return self.nextPid }
        self.executeTasks()
        return self.nextPid
    }
    
    @discardableResult open func executeTasks() -> Int? {
        self.tasks.removeIndexes(at: self.tasks.enumerated().filter { $0.element.isCancelled }.map { $0.offset })
        
        var pid: Int? = nil
        
        self.tasks.filter { !$0.isRunning && !$0.isCancelled }.forEach {
            pid = pid ?? $0.pid
            self._processing = true
            thread.async(execute: $0.workItem)
        }
        
        return self.pid
    }
    
    @discardableResult open func cancelTask(pid: Int) -> Bool {
        guard let task = self.tasks.first(where: { $0.pid == pid }), !task.isCancelled else {
            return false
        }
                
        task.cancel()
        if let taskPid = task.pid, !task.isRunning, let index = self.tasks.firstIndex(where: { $0.pid == taskPid }) {
            self.tasks.remove(at: index)
        }
        return true
    }
    
    open func cancelAllTasks() {
        tasks.forEach({ $0.cancel() })
        if !self.processing { tasks.removeAll() }
    }
    
    open func removeAllTasks() {
        tasks.removeAll()
    }
    
    open func removeTask(at index: Int) {
        tasks.remove(at: index)
    }
    
    open func finishTask(_ task: Task) {
        
        if ( !task.isCancelled ) {
            task.completed?(task)
        }
        self.tasks.removeIndexes(at: self.tasks.enumerated().filter { $0.element.pid == pid }.map { $0.offset })
        self.task = nil
        
        self._processing = self._processing && !self.tasks.isEmpty ? false : self._processing
        self.executeTasks()
    }
    
}
