//
//  DispatchQueue.swift
//  CommonKit
//
//  Created by Oskari Rauta on 29/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    public static var background: DispatchQueue {
        return DispatchQueue.global(qos: .background)
    }
    
    open func async(execute: @escaping () -> Void, completion: @escaping () -> Void, completionDelay: Double = 0.0) {
        self.async(execute: {
            execute()
            DispatchQueue.main.delay(completionDelay, execute: completion)
        })
    }
    
    open func delay(_ delay: Double, execute: @escaping () -> Void) {
        self.asyncAfter(deadline: .now() + delay, execute: execute)
    }
    
    open func delay(_ delay: Double, execute: DispatchWorkItem) {
        self.asyncAfter(deadline: .now() + delay, execute: execute)
    }
    
}

