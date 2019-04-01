//
//  UIViewControllerExtended.swift
//  CommonKit
//
//  Created by Oskari Rauta on 01.04.19.
//  Copyright © 2019 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class UIViewControllerExtended: UIViewController, BackButtonProtocol {

    open var _backBtn: UIBarButtonItem? = nil
    
    internal var _viewIsBeingDisplayed: Bool = false
    open var viewIsBeingDisplayed: Bool { get { return self._viewIsBeingDisplayed }}

    open func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = self.navigationController?.viewControllers.count == 1 ? nil : self.backBtn
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self._viewIsBeingDisplayed = true
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        self._viewIsBeingDisplayed = false
        super.viewWillDisappear(animated)
    }
    
}
