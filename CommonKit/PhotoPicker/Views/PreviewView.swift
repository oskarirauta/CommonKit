//
//  PreviewView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension PhotoPickerView {
    
    open class PreviewView: UIImageView, DefaultAlertActionProtocol {
        
        public lazy var defaults: DefaultAlertProperties = DefaultAlertProperties()
        
        public lazy var buttonFont: [AlertActionStyle : UIFont] = self.defaults.buttonFont
        public lazy var buttonTextColor: [AlertActionStyle : UIColor] = self.defaults.buttonTextColor
        public lazy var buttonBgColor: [AlertActionStyle : UIColor] = self.defaults.buttonBgColor
        public lazy var buttonBgColorHighlighted: [AlertActionStyle : UIColor] = self.defaults.buttonBgColorHighlighted
        public lazy var buttonCornerRadius: CGFloat = self.defaults.buttonCornerRadius
        public lazy var buttonHeight: CGFloat = self.defaults.buttonHeight
        public lazy var buttonMargin: CGFloat = self.defaults.buttonMargin

        open var cancel_handler: (() -> ())? = nil
        open var accept_handler: (() -> ())? = nil
        
        open lazy var buttonCancel: AlertButton = {
            [unowned self] in
            var _buttonCancel: AlertButton = AlertButton()
            _buttonCancel.translatesAutoresizingMaskIntoConstraints = false
            self.setButton(&_buttonCancel, style: .destructive)
            
            _buttonCancel.setBackgroundImage(self.buttonBgColor[.destructive]?.darker(by: 31).image, for: UIControlState())
            _buttonCancel.setBackgroundImage(self.buttonBgColor[.destructive]?.darker(by: 31).image, for: .selected)
            _buttonCancel.setBackgroundImage(self.buttonBgColorHighlighted[.destructive]?.darker(by: 26).image, for: .highlighted)
            
            _buttonCancel.setImage(UIImage(named: "photopicker_cancel")?.scaled(to: CGSize(width: 66.0, height: 66.0)).withRenderingMode(.alwaysTemplate))
            
            _buttonCancel.imageEdgeInsets = UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0)
            _buttonCancel.alpha = 0.94
            
            _buttonCancel.isEnabled = true
            _buttonCancel.layer.cornerRadius = 66.0 / 2
            _buttonCancel.layer.borderWidth = 2.0
            _buttonCancel.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
            _buttonCancel.layer.shadowRadius = 6.0
            _buttonCancel.addTarget(self, action: #selector(self.action_cancel), for: .touchUpInside)
            
            return _buttonCancel
            }()
        
        open lazy var buttonAccept: AlertButton = {
            [unowned self] in
            var _buttonAccept: AlertButton = AlertButton()
            _buttonAccept.translatesAutoresizingMaskIntoConstraints = false
            self.setButton(&_buttonAccept, style: .accept)
            
            _buttonAccept.setBackgroundImage(self.buttonBgColor[.accept]?.darker(by: 40).image, for: UIControlState())
            _buttonAccept.setBackgroundImage(self.buttonBgColor[.accept]?.darker(by: 40).image, for: .selected)
            _buttonAccept.setBackgroundImage(self.buttonBgColorHighlighted[.accept]?.darker(by: 34).image, for: .highlighted)
            
            _buttonAccept.setImage(UIImage(named: "photopicker_accept")?.scaled(to: CGSize(width: 66.0, height: 66.0)).withRenderingMode(.alwaysTemplate))
            
            _buttonAccept.imageEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
            _buttonAccept.alpha = 0.94
            
            _buttonAccept.isEnabled = true
            _buttonAccept.layer.cornerRadius = 66.0 / 2
            _buttonAccept.layer.borderWidth = 2.0
            _buttonAccept.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
            _buttonAccept.layer.shadowRadius = 6.0
            _buttonAccept.addTarget(self, action: #selector(self.action_accept), for: .touchUpInside)
            
            return _buttonAccept
            }()
        
        open lazy var bottomOverlay: CALayer = {
            var _bottomOverlay: CALayer = CALayer()
            _bottomOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.55).cgColor
            return _bottomOverlay
        }()
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.contentMode = .scaleAspectFill
            self.isUserInteractionEnabled = true
            
            self.layer.addSublayer(self.bottomOverlay)
            self.addSubview(self.buttonCancel)
            self.addSubview(self.buttonAccept)
            
            self.buttonCancel.widthAnchor.constraint(equalToConstant: 66.0).isActive = true
            self.buttonCancel.heightAnchor.constraint(equalTo: self.buttonCancel.widthAnchor).isActive = true
            self.buttonCancel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -60).isActive = true
            self.buttonCancel.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -38).isActive = true
            
            self.buttonAccept.widthAnchor.constraint(equalToConstant: 66.0).isActive = true
            self.buttonAccept.heightAnchor.constraint(equalTo: self.buttonCancel.widthAnchor).isActive = true
            self.buttonAccept.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 60).isActive = true
            self.buttonAccept.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -38).isActive = true
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        open override func layoutSubviews() {
            super.layoutSubviews()
            self.bottomOverlay.frame = CGRect(x: 0, y: self.bounds.height - 76.0, width: self.bounds.width, height: 76.0)
        }
        
        @objc func action_cancel() {
            self.cancel_handler?()
        }
        
        @objc func action_accept() {
            self.accept_handler?()
        }
        
    }
}
