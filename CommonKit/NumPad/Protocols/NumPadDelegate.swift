//
//  NumPadDelegate.swift
//  CommonKit
//
//  Created by Oskari Rauta on 09.01.19.
//  Copyright © 2019 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol NumPadDelegate {
    
    var valueForNumpad: Decimal? { get set }
    var clearButtonMode: UITextField.ViewMode { get set }
}
