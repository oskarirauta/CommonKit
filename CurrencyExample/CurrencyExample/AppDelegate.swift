//
//  AppDelegate.swift
//  CurrencyExample
//
//  Created by Oskari Rauta on 07/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit
import CommonKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppLocale {
    
    var regionCode: String = "fi_FI"
    
    func test() {
        var wallet: Money = Money(100.0)
        var cart: Cart = Cart()
        cart.append(CartItem(name: "Item1", price: 15.0))
        cart.append(CartItem(name: "Item2", price: 10.0, VAT: 24.0))
        cart.append(CartItem(name: "Item3", count: 2, unit: "pcs", price: 15.0, VAT: 24.0))
        cart.append(CartItem(name: "Item4", count: 0, price: 20.0))
        cart.append(CartItem(name: "Item5", count: 0, price: 9.0, VAT: 24.0))
        cart.append(CartItem(name: "Item6", count: 0, price: 1.0))
        
        cart[3].VAT_percent = 15.5
        cart[5].count = 1
        
        cart.forEach {
            var line: String = ( $0.name ?? "--" ) + "\t| "
            line += $0.price.description + "\t| "
            line += $0.count.description + ( $0.unit ?? "\t" ) + "\t| "
            line += $0.VAT_percent.description + "%\t| "
            line += $0.VAT.description + "\t| "
            line += $0.totalVAT0.description + "\t| "
            line += $0.total.description
            print(line)
        }
        
        print("\t\t\t\t\t\t\t\t\t  " + cart.VAT.description + "\t| " + cart.totalVAT0.description + "\t| " + cart.total.description)
        
        
        print("Wallet contains: " + wallet.description)
        
        wallet -= Money(cart)
        
        print("After purchase of " + cart.total.description + ", wallet contains: " + wallet.description)
        
    }
    
    lazy var window: UIWindow? = {
        let _window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        _window.backgroundColor = UIColor.white
        _window.rootViewController = ViewController()
        _window.makeKeyAndVisible()
        return _window
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let _ = self.window
        
        self.test()
        
        // Override point for customization after application launch.
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
