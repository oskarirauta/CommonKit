//
//  DefaultActionSheetControllerBaseClass.swift
//  CommonKit
//
//  Created by Oskari Rauta on 12/10/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class DefaultActionSheetControllerBaseClass: DefaultAlertControllerBaseClass {
    
    open override var fullscreen: Bool { get { return false } }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Initializer
    public override init(title: String?, preferredStyle: AlertControllerStyle) {
        super.init(nibName: nil, bundle: nil)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overFullScreen
        self.setupNotifications()
        self.title = title
        self._preferredStyle = preferredStyle
        self.setupView()
        self.setupConstraints()
    }
    
    public override init() {
        super.init(nibName: nil, bundle: nil)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overFullScreen
        self.setupNotifications()
        self.title = nil
        self._preferredStyle = .alert
        self.setupView()
        self.setupConstraints()
    }
    
    public override init(stockInit: Bool, preferredStyle: AlertControllerStyle = .alert) {
        super.init(nibName: nil, bundle: nil)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overFullScreen
        self.setupNotifications()
        self.title = nil
        self._preferredStyle = preferredStyle
        
        if !stockInit {
            self.setupView()
            self.setupConstraints()
        }
    }
    
}
