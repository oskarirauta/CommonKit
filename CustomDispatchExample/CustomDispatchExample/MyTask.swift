//
//  MyTask.swift
//  CustomDispatchExample
//
//  Created by Oskari Rauta on 27/09/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CommonKit

public final class MyTask: TaskClass {    
    
    var value: Int = -10
    
    public func taskCode(_ task: Task) {
        
        var cnt: Int = 0
        print("(class) Running pid " + String(task.pid ?? -1))
        
        let endTime: TimeInterval = Date().timeIntervalSinceReferenceDate + 3

        var i: Int = 0
        while Date().timeIntervalSinceReferenceDate < endTime && !task.isCancelled {
            i = Int.random(20)
            cnt += 1
            self.value = i
        }
        
        if ( !task.isCancelled ) {
            task.result = Int(i)
        } else { print("Cancelling (class) task " + String(task.pid ?? -1)) }
        
    }
    
    public func taskCompleted(_ task: Task) {
        
        let i: Int? = task.result as? Int
        
        print("(class) Task #" + String(task.pid ?? -1) + " completed " + (task.isCancelled ? "with failure. " : "with success. ") + "Result is " + ( i == nil ? "nil" : i!.description ))
    }
    
}

