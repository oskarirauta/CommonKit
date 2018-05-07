//
//  UIControl.swift
//  CommonKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension UIControl {
    
    public func add(for controlEvents: UIControlEvents, _ execute: @escaping () -> (Void)) {
        
        self.addTarget(ClosureSleeve(for: self, execute), action: #selector(ClosureSleeve.invoke), for: controlEvents)
    }
    
}
