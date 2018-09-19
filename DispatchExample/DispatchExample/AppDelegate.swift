//
//  AppDelegate.swift
//  DispatchExample
//
//  Created by Oskari Rauta on 06/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit
import CommonKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var window: UIWindow? = {
        let _window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        _window.rootViewController = ViewController()
        _window.rootViewController?.view.backgroundColor = UIColor.white
        _window.makeKeyAndVisible()
        return _window
    }()
    
    var taskScheduler: TaskScheduler = TaskScheduler()
    var myTask: MyTask {
        return MyTask(taskScheduler: self.taskScheduler)
    }
    var myTask2: MyTask2 {
        return MyTask2(taskScheduler: self.taskScheduler)
    }
    var task: Task {
        return Task(nil, taskScheduler: self.taskScheduler, block: {
            
            var cnt: Int = 0
            print("Running pid " + String($0.pid ?? -1))
            var i: Int = 0
            while (( i != 9999 ) && ( !$0.isCancelled )) {
                i = Int.random(50000)
                print("#" + String(cnt) + ": " + String(i))
                cnt+=1
            }
            
            if ( !$0.isCancelled ) {
                $0.result = Int(i)
            } else { print("Cancelling task " + String($0.pid ?? -1)) }
            
            print(($0.isCancelled ? "Cancelled" : "Finished" ) + " pid #" + String($0.pid ?? -1))
            
        }, completed: {
            print("Task #" + String($0.pid ?? -1) + " completed " + ($0.isCancelled ? "with failure" : "with success"))
            if let i: Int = $0.result as? Int { print("Result is \(i)") }
        })
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let _ = self.window
        
        let pid: Int = taskScheduler.addTask(execute: {
            var cnt: Int = 0
            print("Running pid " + String($0.pid ?? -1))
            var i: Int = -1
            while (( i != 0 ) && ( !$0.isCancelled )) { // This task should be cancelled, so it runs forever
                i = Int.random(lower: 1, 50000)
                // print("#" + String(cnt) + ": " + String(i))
                cnt+=1
            }
            
            if ( !$0.isCancelled ) {
                $0.result = Int(i)
            } else { print("Cancelling task " + String($0.pid ?? -1)) }
            
            print(($0.isCancelled ? "Cancelled" : "Finished" ) + " pid #" + String($0.pid ?? -1))
        }, completed: {
            print("Task #" + String($0.pid ?? -1) + " completed " + ($0.isCancelled ? "with failure" : "with success"))
            if let i: Int = $0.result as? Int { print("Result is \(i)") }
        }, wait: true)
        
        var classPid: Int = taskScheduler.addTask(execute: myTask)
        print("myTask added to queue with pid #" + String(classPid))

        classPid = taskScheduler.addTask(execute: myTask.taskCopy())
        print("Copy of myTask added to queue with pid #" + String(classPid))
        
        taskScheduler.addTask(execute: myTask2)
        
        taskScheduler.addTask(execute: self.task, wait: true)
        
        taskScheduler.addTask(execute: {
            _ in
            doNothing()
        }, completed: {
            _ in
            print("Last task has finished.")
        }, wait: true)
        
        taskScheduler.executeTasks() // We commence start, because all tasks were added with wait feature
        
        DispatchQueue.background.delay(0.1, execute: { // Cancel first task
            let ret: Bool = self.taskScheduler.cancelTask(pid: pid)
            print("Task #" + String(pid) + " cancel" + ( ret ? "led succesfully." : " failed."))
        })
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
