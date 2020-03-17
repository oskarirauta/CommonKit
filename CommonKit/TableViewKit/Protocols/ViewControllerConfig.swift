//
//  ViewControllerConfig.swift
//  CommonKit
//
//  Created by Oskari Rauta on 15.03.20.
//  Copyright © 2020 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol ViewControllerConfig {
    
    @objc optional var _viewControllerConfig: (UIViewController) -> Void { get set }
    @objc optional var viewControllerConfig: (UIViewController) -> Void { get set }
}
