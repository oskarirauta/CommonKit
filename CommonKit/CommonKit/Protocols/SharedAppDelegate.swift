//
//  SharedAppDelegate.swift
//  CommonKit
//
//  Created by Oskari Rauta on 05/09/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol SharedAppDelegate {
    associatedtype selfType = Self
    static var shared: selfType { get }
}

public extension SharedAppDelegate where Self: UIResponder, Self: UIApplicationDelegate {
    
    public static var shared: selfType {
        get {
            return Thread.isMainThread ? ( UIApplication.shared.delegate as! selfType ) : { DispatchQueue.main.sync { return UIApplication.shared.delegate as! selfType }
                }()
        }
    }
}
