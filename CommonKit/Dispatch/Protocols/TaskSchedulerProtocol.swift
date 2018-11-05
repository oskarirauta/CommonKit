//
//  TaskSchedulerProtocol.swift
//  DispatchKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol AbstractTaskSchedulerProtocol {
    var thread: DispatchQueue { get }
    func finishTask(_ task: Task)
}

public protocol TaskSchedulerProtocol: class {
    var task: Task? { get }
    var tasks: [Task] { get }
    var pid: Int? { get }
    var processing: Bool { get }
    var nextPid: Int { get }

    init(thread: DispatchQueue)

    func addTask(execute: @escaping TaskBlock, completed: TaskBlock?, wait: Bool) -> Int
    func addTask(execute: Task, wait: Bool) -> Int
    func executeTasks() -> Int?
    func cancelTask(pid: Int) -> Bool
    func cancelAllTasks()
    func removeAllTasks()
    func removeTask(at index: Int)
}
