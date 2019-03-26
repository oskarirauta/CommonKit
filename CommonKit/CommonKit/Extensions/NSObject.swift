//
//  NSObject.swift
//  CommonKit
//
//  Created by Oskari Rauta on 29/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public typealias dispatch_cancelable_closure = (Bool) -> (Void)

public extension NSObject {
    
    final var className:String { return "\(type(of: self))" }
    
    final func cancelDelay(closure: inout dispatch_cancelable_closure?) {
        closure?(true)
        closure = nil
    }
    
    @discardableResult
    final func delay( time:TimeInterval, closure: @escaping () -> (Void)) -> dispatch_cancelable_closure? {
        
        func dispatch_later(closure: @escaping () -> (Void)) {
            DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: closure)
        }
        
        var closure: (() -> (Void))? = closure
        var cancelableClosure: dispatch_cancelable_closure?
        
        let delayedClosure: dispatch_cancelable_closure = {
            cancel in
            if !cancel, let closure = closure {
                DispatchQueue.main.async(execute: closure)
            }
            closure = nil
            cancelableClosure = nil
        }
        
        cancelableClosure = delayedClosure
        
        dispatch_later {
            if let delayedClosure = cancelableClosure { delayedClosure(false ) }
        }
        
        return cancelableClosure
    }
    
    final func waitWhile(condition: @escaping () -> Bool?, completion: @escaping () -> () ) {
        guard let conditionMet:Bool = condition() else { return }
        
        guard !conditionMet else {
            completion()
            return
        }
        
        delay(time: 0.05) { self.waitWhile(condition: condition, completion: completion) }
    }
    
}

/* Example code:

var b: Bool = false
var i: Int = 0

func test() {
    
    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false, block: {
        _ in
        self.b = true
    })
    
    waitWhile(condition: {
        [weak self] in
        guard let weakSelf = self else { return nil }
        weakSelf.i += 1
        print("\(weakSelf.i) Checking: " + ( weakSelf.b ? "true" : "false"))
        return weakSelf.b
        }, completion: {
            [weak self] in
            if let weakSelf = self {
                print("Completion reached, b is " + ( weakSelf.b ? "true" : "false"))
            }
    })
}
*/
