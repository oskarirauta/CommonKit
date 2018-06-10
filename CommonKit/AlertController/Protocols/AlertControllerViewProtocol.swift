//
//  AlertControllerViewProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public protocol AlertControllerViewProtocol {
    
    // Defaults
    var defaults: DefaultAlertProperties { get }

    // Settings
    var fullscreen: Bool { get }
    var preferredStyle: AlertControllerStyle { get }
    var actionSheetBounceHeight: CGFloat { get }
    
    // OverlayView
    var overlayView: UIView { get }
    var overlayColor: UIColor { get }
    
    // ContainerView
    var containerView: UIView { get }
    
    // ContentView
    var contentView: UIView { get }
    var contentViewBgColor: UIColor { get }
    
    // Controller's view
    var view: UIView! { get set }
}
