//
//  MyTask.swift
//  DispatchExample
//
//  Created by Oskari Rauta on 11/07/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CommonKit

public final class MyTask: TaskClass {
    
    var value: Int = -10
    
    public func taskCode(_ task: Task) {
        
        var cnt: Int = 0
        print("(class) Running pid " + String(task.pid ?? -1))
        var i: Int = 0
        while (( i != 10 ) && ( !task.isCancelled )) {
            i = Int.random(20)
            print("(class) #" + String(cnt) + ": " + String(i))
            cnt+=1
            self.value = i
        }
        
        if ( !task.isCancelled ) {
            task.result = Int(i)
        } else { print("Cancelling (class) task " + String(task.pid ?? -1)) }
        
        print((task.isCancelled ? "Cancelled" : "Finished" ) + " (class) pid #" + String(task.pid ?? -1))
        
    }
    
    public func taskCompleted(_ task: Task) {
        
        print("(class) Task #" + String(task.pid ?? -1) + " completed " + (task.isCancelled ? "with failure" : "with success"))
        if let i: Int = task.result as? Int { print("(class) Result is \(i)") }
        
        print("(class) value is \(self.value)")
    }
    
}

// You can also introduce your custom Task Class like this, previous is just typealias for this.

public final class MyTask2: Task, CustomTask {
    
    var value: Int = -10
    
    public func taskCode(_ task: Task) {
        
        var cnt: Int = 0
        print("(class) Running pid " + String(task.pid ?? -1))
        var i: Int = 0
        while (( cnt < 20 ) && ( !task.isCancelled )) {
            i = Int.random(20)
            print("(class) #" + String(cnt) + ": " + String(i))
            cnt+=1
            self.value = i
        }
        
        if ( !task.isCancelled ) {
            task.result = Int(i)
        } else { print("Cancelling (class) task " + String(task.pid ?? -1)) }
        
        print((task.isCancelled ? "Cancelled" : "Finished" ) + " (class) pid #" + String(task.pid ?? -1))
        
    }
    
    public func taskCompleted(_ task: Task) {
        
        print("(class) Task #" + String(task.pid ?? -1) + " completed " + (task.isCancelled ? "with failure" : "with success"))
        if let i: Int = task.result as? Int { print("(class) Result is \(i)") }
        
        print("(class) value is \(self.value)")
    }
    
}


