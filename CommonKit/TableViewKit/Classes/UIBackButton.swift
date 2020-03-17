//
//  UIBackButton.swift
//  CommonKit
//
//  Created by Oskari Rauta on 12.03.20.
//  Copyright © 2020 Oskari Rauta. All rights reserved.
//

import UIKit

open class UIBackButton: UIBarButtonItem {

    open var backAction: (() -> Void)? = nil
    
    public static var backButtonImage: UIImage? {
        return UIImage(named: "BackBtn", in: Bundle(for: UIViewController.Extended.self), compatibleWith: nil)?.stretchableImage(withLeftCapWidth: 38, topCapHeight: 64).template
    }
    
    public static var `default`: UIBackButton {
        return UIBackButton(image: self.backButtonImage)
    }
    
    public convenience init(image: UIImage?) {
        self.init(image: image, style: .plain, target: nil, action: nil)
        self.isEnabled = true
        self.add(self.backAction)
    }
        
}
