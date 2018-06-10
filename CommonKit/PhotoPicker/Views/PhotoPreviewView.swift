//
//  PhotoPreviewView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension PhotoPickerView {
    
    open class PhotoPreviewView: UIImageView, DefaultAlertActionProtocol {
        
        public lazy var defaults: DefaultAlertProperties = DefaultAlertProperties()
        
        public lazy var buttonFont: [AlertActionStyle : UIFont] = self.defaults.buttonFont
        public lazy var buttonTextColor: [AlertActionStyle : UIColor] = self.defaults.buttonTextColor
        public lazy var buttonBgColor: [AlertActionStyle : UIColor] = self.defaults.buttonBgColor
        public lazy var buttonBgColorHighlighted: [AlertActionStyle : UIColor] = self.defaults.buttonBgColorHighlighted
        public lazy var buttonCornerRadius: CGFloat = self.defaults.buttonCornerRadius
        public lazy var buttonHeight: CGFloat = self.defaults.buttonHeight
        public lazy var buttonMargin: CGFloat = self.defaults.buttonMargin

        open var back_handler: (() -> ())? = nil
        
        open lazy var title: UILabel = {
            var _title: UILabel = UILabel()
            _title.translatesAutoresizingMaskIntoConstraints = false
            _title.textColor = UIColor.white
            _title.font = UIFont.boldSystemFont(ofSize: 14.5)
            _title.text = nil
            _title.textAlignment = .left
            _title.numberOfLines = 1
            _title.lineBreakMode = .byTruncatingTail
            _title.setContentHuggingPriority(.defaultLow, for: .horizontal)
            return _title
        }()
        
        open lazy var buttonBack: UIButton = {
            [unowned self] in
            var _buttonBack: UIButton = UIButton()
            _buttonBack.translatesAutoresizingMaskIntoConstraints = false
            _buttonBack.clipsToBounds = true
            
            _buttonBack.setImage(UIImage(named: "photopicker_back")?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: UIControlState())
            _buttonBack.setImage(UIImage(named: "photopicker_back")?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: .highlighted)
            _buttonBack.setImage(UIImage(named: "photopicker_back")?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: .selected)
            
            _buttonBack.tintColor = UIColor.black
            _buttonBack.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
            _buttonBack.setBackgroundImage(UIColor.gray.image, for: UIControlState())
            _buttonBack.setBackgroundImage(UIColor.gray.image, for: .selected)
            _buttonBack.setBackgroundImage(UIColor.lightGray.image, for: .highlighted)
            _buttonBack.alpha = 0.75
            
            _buttonBack.isEnabled = true
            _buttonBack.layer.cornerRadius = self.buttonCornerRadius
            _buttonBack.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
            _buttonBack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            
            return _buttonBack
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
            self.addSubview(self.buttonBack)
            self.addSubview(self.title)
            
            self.buttonBack.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -38).isActive = true
            self.buttonBack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0).isActive = true
            
            self.title.centerYAnchor.constraint(equalTo: self.buttonBack.centerYAnchor).isActive = true
            self.title.leadingAnchor.constraint(equalTo: self.buttonBack.trailingAnchor, constant: 20.0).isActive = true
            self.title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10.0).isActive = true
            
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        open override func layoutSubviews() {
            super.layoutSubviews()
            self.bottomOverlay.frame = CGRect(x: 0, y: self.bounds.height - 76.0, width: self.bounds.width, height: 76.0)
        }
        
        @objc func action_back() {
            self.back_handler?()
        }
        
    }
}

