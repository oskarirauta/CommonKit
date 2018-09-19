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
    
    open class PhotoPreviewView: AlertImageView {
        
        open var back_handler: (() -> ())? = nil
        
        open lazy var title: UILabel = UILabel.create {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textColor = UIColor.white
            $0.font = UIFont.boldSystemFont(ofSize: 14.5)
            $0.text = nil
            $0.textAlignment = .left
            $0.numberOfLines = 1
            $0.lineBreakMode = .byTruncatingTail
            $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        }
        
        open lazy var buttonBack: UIButton = UIButton.create {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.clipsToBounds = true
            
            $0.setImage(UIImage(named: "photopicker_back", in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: UIControl.State())
            $0.setImage(UIImage(named: "photopicker_back", in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: .highlighted)
            $0.setImage(UIImage(named: "photopicker_back", in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: .selected)
            
            $0.tintColor = UIColor.black
            $0.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
            $0.setBackgroundImage(UIColor.gray.image, for: UIControl.State())
            $0.setBackgroundImage(UIColor.gray.image, for: .selected)
            $0.setBackgroundImage(UIColor.lightGray.image, for: .highlighted)
            $0.alpha = 0.75
            
            $0.isEnabled = true
            $0.layer.cornerRadius = self.buttonCornerRadius ?? DefaultAlertProperties.buttonCornerRadius
            $0.addTarget(self, action: #selector(self.action_back), for: .touchUpInside)
            $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        }
        
        open lazy var bottomOverlay: CALayer = CALayer.create {
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.55).cgColor
        }
        
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

