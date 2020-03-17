//
//  UIViewControllerExtended.swift
//  CommonKit
//
//  Created by Oskari Rauta on 01.04.19.
//  Copyright © 2019 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
        
    open class Extended: UIViewController, ViewControllerConfig, BackButton  {
        
        open var _backButton: UIBackButton? = nil
        
        public required init() {
            super.init(nibName: nil, bundle: nil)
            (self as ViewControllerConfig?)?._viewControllerConfig?(self)
            (self as ViewControllerConfig?)?.viewControllerConfig?(self)
        }
        
        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        open func backAction() {
            self.navigationController?.popViewController(animated: true)
        }
        
        override open func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationItem.leftBarButtonItem = ( self.navigationController?.viewControllers.count ?? 0 ) < 2 ? nil : self.backButton
        }
        
    }
}
