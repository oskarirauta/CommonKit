//
//  CustomTaskProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/07/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol CustomTask: class {
    init(_ pid: Int?, taskScheduler: TaskScheduler)
    func taskCode(_ task: Task)
    func taskCompleted(_ task: Task)
}

extension CustomTask where Self: Task {
    
    public init(_ pid: Int? = nil, taskScheduler: TaskScheduler) {
        self.init(pid, taskScheduler: taskScheduler, block: { _ in }, completed: nil)
        self.override(block: self.taskCode, completed: self.taskCompleted)
    }
}
