//
//  PhotoView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension PhotoPickerView {
    
    open var photoCollection: UICollectionView {
        get { return self.photoView.collectionView }
        set { self.photoView.collectionView = newValue }
    }
    
    open class PhotoView: AlertView {
        
        open var albumTitle: String? = nil {
            didSet {
                self.buttonAlbum.setTitle(self.albumTitle, for: UIControlState())
            }
        }
        
        open var delegate: UICollectionViewDelegate? {
            get { return self.collectionView.delegate }
            set { self.collectionView.delegate = newValue }
        }
        
        open var datasource: UICollectionViewDataSource? {
            get { return self.collectionView.dataSource }
            set { self.collectionView.dataSource = newValue }
        }
        
        open var album_handler: (() -> ())? = nil
        open var cancel_handler: (() -> ())? = nil
        open var accept_handler: (() -> ())? = nil
        open var camera_handler: (() -> ())? = nil
        
        open lazy var buttonAlbum: UIButton = UIButton.create {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setTitle(self.albumTitle, for: UIControlState())
            $0.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16.5) ?? UIFont.systemFont(ofSize: 16.5)
            $0.setTitleColor(UIColor.black, for: UIControlState())
            $0.addTarget(self, action: #selector(self.action_album(_:)), for: .touchUpInside)
        }
        
        open lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).properties {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = UIColor.clear
            $0.isScrollEnabled = true
            $0.scrollsToTop = true
            $0.bounces = true
            $0.tag = 0
            $0.contentInset = UIEdgeInsetsMake(5.0, 3.0, 3.0, 3.0)
            
            $0.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        }
        
        open lazy var buttonArea: UIView = UIView.create {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.addSubview(self.buttonCancel)
            $0.addSubview(self.buttonOK)
            $0.addSubview(self.buttonCamera)
        }
        
        open lazy var buttonCancel: AlertButton = {
            [unowned self] in
            var _buttonCancel: AlertButton = AlertButton()
            _buttonCancel.translatesAutoresizingMaskIntoConstraints = false
            self.setButton(&_buttonCancel, style: .cancel)
            _buttonCancel.setBackgroundImage((self.buttonBgColorHighlighted[.cancel] ?? DefaultAlertProperties.buttonBgColorHighlighted[.cancel])?.image, for: .highlighted)
            _buttonCancel.setTitle(NSLocalizedString("CANCEL", comment: "CANCEL"))
            _buttonCancel.isEnabled = true
            _buttonCancel.addTarget(self, action: #selector(self.action_cancel(_:)), for: .touchUpInside)
            
            return _buttonCancel
            }()
        
        open lazy var buttonOK: AlertButton = {
            [unowned self] in
            var _buttonOK: AlertButton = AlertButton()
            _buttonOK.translatesAutoresizingMaskIntoConstraints = false
            self.setButton(&_buttonOK, style: .default)
            _buttonOK.setBackgroundImage((self.buttonBgColorHighlighted[.default] ?? DefaultAlertProperties.buttonBgColorHighlighted[.default])?.image, for: .highlighted)
            _buttonOK.setTitle(NSLocalizedString("OK", comment: "OK"))
            _buttonOK.isEnabled = true
            _buttonOK.addTarget(self, action: #selector(self.action_accept(_:)), for: .touchUpInside)
            
            return _buttonOK
            }()
        
        open lazy var buttonCamera: AlertButton = {
            [unowned self] in
            var _buttonCamera: AlertButton = AlertButton()
            _buttonCamera.translatesAutoresizingMaskIntoConstraints = false
            self.setButton(&_buttonCamera, style: .default)
            _buttonCamera.setBackgroundImage((self.buttonBgColorHighlighted[.default] ?? DefaultAlertProperties.buttonBgColorHighlighted[.default])?.image, for: .highlighted)
            _buttonCamera.setImage(UIImage(named: "photopicker_camera", in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate))
            _buttonCamera.imageEdgeInsets = UIEdgeInsets(top: 4.0, left: 6.0, bottom: 4.0, right: 6.0)
            _buttonCamera.isEnabled = true
            _buttonCamera.addTarget(self, action: #selector(self.action_camera(_:)), for: .touchUpInside)
            
            return _buttonCamera
            }()
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            self.addSubview(self.buttonAlbum)
            self.addSubview(self.collectionView)
            self.addSubview(self.buttonArea)
            
            // Constraints
            
            self.buttonAlbum.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.buttonAlbum.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.buttonAlbum.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.buttonAlbum.heightAnchor.constraint(equalToConstant: self.buttonHeight ?? DefaultAlertProperties.buttonHeight).isActive = true
            
            self.collectionView.topAnchor.constraint(equalTo: self.buttonAlbum.bottomAnchor, constant: 2.0).isActive = true
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            
            self.buttonArea.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 8.0).isActive = true
            self.buttonArea.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.buttonArea.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.buttonArea.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
            self.buttonCancel.topAnchor.constraint(equalTo: self.buttonArea.topAnchor).isActive = true
            self.buttonCancel.bottomAnchor.constraint(equalTo: self.buttonArea.bottomAnchor).isActive = true
            self.buttonCancel.heightAnchor.constraint(equalToConstant: self.buttonHeight ?? DefaultAlertProperties.buttonHeight).isActive = true
            self.buttonCancel.leadingAnchor.constraint(equalTo: self.buttonArea.leadingAnchor).isActive = true
            self.buttonCancel.widthAnchor.constraint(equalToConstant: self.buttonCancel.intrinsicContentSize.width + ( 2 * 15.0 )).isActive = true
            
            self.buttonOK.topAnchor.constraint(equalTo: self.buttonArea.topAnchor).isActive = true
            self.buttonOK.bottomAnchor.constraint(equalTo: self.buttonArea.bottomAnchor).isActive = true
            self.buttonOK.centerXAnchor.constraint(equalTo: self.buttonArea.centerXAnchor).isActive = true
            self.buttonOK.leadingAnchor.constraint(greaterThanOrEqualTo: self.buttonCancel.trailingAnchor, constant: self.buttonMargin ?? DefaultAlertProperties.buttonMargin).isActive = true
            self.buttonOK.trailingAnchor.constraint(lessThanOrEqualTo: self.buttonCamera.leadingAnchor, constant: -(self.buttonMargin ?? DefaultAlertProperties.buttonMargin)).isActive = true
            self.buttonOK.heightAnchor.constraint(equalToConstant: self.buttonHeight ?? DefaultAlertProperties.buttonHeight).isActive = true
            self.buttonOK.widthAnchor.constraint(equalToConstant: self.buttonOK.intrinsicContentSize.width + ( 2 * 15.0 )).isActive = true
            
            self.buttonCamera.topAnchor.constraint(equalTo: self.buttonArea.topAnchor).isActive = true
            self.buttonCamera.bottomAnchor.constraint(equalTo: self.buttonArea.bottomAnchor).isActive = true
            self.buttonCamera.heightAnchor.constraint(equalToConstant: self.buttonHeight ?? DefaultAlertProperties.buttonHeight).isActive = true
            self.buttonCamera.trailingAnchor.constraint(equalTo: self.buttonArea.trailingAnchor).isActive = true
            
            let hasCamera : Bool = UIImagePickerController.isSourceTypeAvailable(.camera)
            
            if (( AVCaptureDevice.authorizationStatus(for: .video) != .authorized ) && ( !hasCamera )) {
                self.buttonCamera.removeFromSuperview()
            }
            
            
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        @objc open func action_album(_ sender: AnyObject) {
            self.album_handler?()
        }
        
        @objc open func action_cancel(_ sender: AnyObject) {
            self.cancel_handler?()
        }
        
        @objc open func action_accept(_ sender: AnyObject) {
            self.accept_handler?()
        }
        
        @objc open func action_camera(_ sender: AnyObject) {
            self.camera_handler?()
        }
        
    }
    
}
