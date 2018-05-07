//
//  ClosureSleeve.swift
//  CommonKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class ClosureSleeve {
    let closure: () -> Void
    
    init(for object: AnyObject, _ closure: @escaping () -> Void) {
        
        self.closure = closure
        
        objc_setAssociatedObject(
            object,
            String(format: "[%d]", arc4random()),
            self,
            objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
        )
    }
    
    @objc open func invoke () {
        closure()
    }
}
