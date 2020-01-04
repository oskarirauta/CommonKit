//
//  AppDelegate.swift
//  CustomDispatchExample
//
//  Created by Oskari Rauta on 27/09/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit
import CommonKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
        let _window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        _window.rootViewController = ViewController()
        _window.rootViewController?.view.backgroundColor = UIColor.systemFill
        _window.makeKeyAndVisible()
        return _window
    }()

    var taskScheduler: MultiTaskScheduler = MultiTaskScheduler()
    
    var myTask1: MyTask {
        return MyTask(taskScheduler: self.taskScheduler)
    }
    var myTask2: MyTask {
        return MyTask(taskScheduler: self.taskScheduler)
    }
    var myTask3: MyTask {
        return MyTask(taskScheduler: self.taskScheduler)
    }
    var myTask4: MyTask {
        return MyTask(taskScheduler: self.taskScheduler)
    }
    var myTask5: MyTask {
        return MyTask(taskScheduler: self.taskScheduler)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let _ = self.window
        
        taskScheduler.addTask(execute: self.myTask1, wait: true)
        taskScheduler.addTask(execute: self.myTask2, wait: true)
        taskScheduler.addTask(execute: self.myTask3, wait: true)
        taskScheduler.addTask(execute: self.myTask4, wait: true)

        print("Tasks in scheduler: " + taskScheduler.tasks.count.description )
        
        DispatchQueue.main.async(execute: {
            self.taskScheduler.executeTasks()
        }, completion: {
            DispatchQueue.main.delay(0.2, execute: {
                self.taskScheduler.addTask(execute: self.myTask5, wait: false)
            })
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

