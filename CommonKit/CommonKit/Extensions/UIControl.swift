//
//  UIControl.swift
//  CommonKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UIControl {
    
    public func add(for controlEvents: UIControl.Event, _ execute: @escaping () -> (Void)) {
        
        self.addTarget(ClosureSleeve(for: self, execute), action: #selector(ClosureSleeve.invoke), for: controlEvents)
    }
    
}
