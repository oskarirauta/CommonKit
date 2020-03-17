//
//  AlertButton.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

@objc open class AlertButton: UIButton {
    
    open lazy var shadowView: UIView = UIView.create {
        [unowned self] in
        $0.alpha = 0.9
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.shadowOpacity = self.layer.shadowOpacity
        $0.layer.shadowOffset = self.layer.shadowOffset
        $0.layer.shadowRadius = self.layer.shadowRadius
        $0.layer.shadowColor = self.layer.shadowColor
        $0.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        $0.layer.masksToBounds = false
    }
    
    override open var isHidden: Bool {
        didSet { self.shadowView.isHidden = self.isHidden }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func setImage(_ image: UIImage?) {
        self.setImage(image, for: UIControl.State())
        self.setImage(image, for: .highlighted)
        self.setImage(image, for: .selected)
    }
    
    open func setBackgroundImage(_ image: UIImage?) {
        self.setBackgroundImage(image, for: UIControl.State())
        self.setBackgroundImage(image, for: .highlighted)
        self.setBackgroundImage(image, for: .selected)
    }
    
    open func setTitle(_ title: String?) {
        self.setTitle(title, for: UIControl.State())
        self.setTitle(title, for: .highlighted)
        self.setTitle(title, for: .selected)
    }
    
    open func setTitleColor(_ color: UIColor?) {
        self.setTitleColor(color, for: UIControl.State())
        self.setTitleColor(color, for: .highlighted)
        self.setTitleColor(color, for: .selected)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if ( self.layer.shadowColor != nil && !self.superview!.subviews.contains(self.shadowView)) {
            
            self.superview!.insertSubview(self.shadowView, belowSubview: self)
            
            self.shadowView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.shadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.shadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.shadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
    }
    
    override open func removeFromSuperview() {
        if self.superview!.subviews.contains(self.shadowView) {
            self.shadowView.removeFromSuperview()
        }
        super.removeFromSuperview()
    }
    
}
