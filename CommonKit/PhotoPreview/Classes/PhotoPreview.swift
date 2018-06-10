//
//  PhotoPreview.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class PhotoPreview: DefaultAlertControllerBaseClass, DefaultAlertActionProtocol {

    open lazy var buttonFont: [AlertActionStyle : UIFont] = self.defaults.buttonFont
    open lazy var buttonTextColor: [AlertActionStyle : UIColor] = self.defaults.buttonTextColor
    open lazy var buttonBgColor: [AlertActionStyle : UIColor] = self.defaults.buttonBgColor
    open lazy var buttonBgColorHighlighted: [AlertActionStyle : UIColor] = self.defaults.buttonBgColorHighlighted
    
    open override var fullscreen: Bool {
        get { return true }
    }
    
    open lazy var previewView: PhotoPickerView.PhotoPreviewView = PhotoPickerView.PhotoPreviewView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = false
        $0.back_handler = self.dismissPreview
        }
    
    open override func setupView() {
        super.setupView()
        self.contentView.addSubview(self.previewView)
    }
    
    open override func setupConstraints() {
        
        super.setupConstraints()
        
        self.previewView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0.0).isActive = true
        self.previewView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0.0).isActive = true
        self.previewView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0.0).isActive = true
        self.previewView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0.0).isActive = true
        
    }
    
    private override init(title: String?, preferredStyle: AlertControllerStyle) {
        super.init(nibName: nil, bundle: nil)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overCurrentContext
        self.setupNotifications()
        self.title = title
        self._preferredStyle = preferredStyle
        self.setupView()
        self.setupConstraints()
        self.previewView.image = nil
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overCurrentContext
        self.setupNotifications()
        self.title = title
        self._preferredStyle = preferredStyle
        self.setupView()
        self.setupConstraints()
        self.previewView.image = nil
    }
    
    private override init() {
        super.init(nibName: nil, bundle: nil)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overCurrentContext
        self.setupNotifications()
        self.title = nil
        self._preferredStyle = .alert
        self.setupView()
        self.setupConstraints()
        self.previewView.image = nil
    }
    
    public init(image: UIImage?, title: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overCurrentContext
        self.setupNotifications()
        self.title = nil
        self._preferredStyle = .alert
        self.setupView()
        self.setupConstraints()
        self.previewView.image = image
        self.previewView.title.text = title
    }
    
    open func dismissPreview() {
        self.dismiss(animated: true, completion: {
            self.previewView.image = nil
        })
    }
    
}

