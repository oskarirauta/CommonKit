//
//  UIBarButtonItem.swift
//  CommonKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    public func add(_ execute: (() -> (Void))? ) {
        self.target = execute == nil ? nil : ClosureSleeve(for: self, execute!)
        self.action = execute == nil ? nil : #selector(ClosureSleeve.invoke)
    }
    
}
