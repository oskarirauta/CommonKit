//
//  CustomTask.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/07/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class CustomTask: Task {
    
    public convenience init(_ pid: Int? = nil, taskScheduler: TaskScheduler) {
        self.init(pid, taskScheduler: taskScheduler, block: { _ in }, completed: nil)
        self.override(block: self.taskCode, completed: self.taskCompleted)
    }
    
    public required init(
        _ pid: Int? = nil,
        taskScheduler: TaskScheduler,
        block: @escaping TaskBlock,
        completed: TaskBlock? = nil
        ) {
        
        super.init(pid, taskScheduler: taskScheduler, block: { _ in }, completed: nil)
        self.override(block: self.taskCode, completed: self.taskCompleted)
    }
    
    open func taskCode(_ task: Task) {
        
    }
    
    open func taskCompleted(_ task: Task) {
        
    }
    
}
