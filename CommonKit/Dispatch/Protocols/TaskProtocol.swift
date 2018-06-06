//
//  BackgroundTaskProtocols.swift
//  DispatchKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public typealias TaskBlock = (Task) -> Void

protocol TaskBaseProtocol: class {
    var block: TaskBlock { get }
    var completed: TaskBlock? { get }
}

public protocol TaskProtocol: class {

    var workItem: DispatchWorkItem! { get }
    
    var pid: Int? { get set }
    var taskScheduler: TaskScheduler? { get }
    var isCancelled: Bool { get }
    var result: Any? { get set }
    
    init(_ pid: Int?, taskScheduler: TaskScheduler, block: @escaping TaskBlock, completed: TaskBlock?)
    
    func finishTask()
    func cancel()
    func perform()
}
