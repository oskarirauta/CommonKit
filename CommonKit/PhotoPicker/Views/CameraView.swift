//
//  CameraView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension PhotoPickerView {
    
    open class CameraView: AlertView, AVCapturePhotoCaptureDelegate {
                
        open var cancel_handler: (() -> ())? = nil
        open var album_handler: (() -> ())? = nil
        open var shoot_handler: ((UIImage) -> ())? = nil
        
        var cameraController: CameraController? = nil
        open var currentCameraPosition: CameraController.CameraPosition? = nil
        
        internal var initial_settings: PhotoPickerSettings? = nil
        
        open class ContentViewClass: UIView {
            
            open lazy var topOverlay: CALayer = CALayer.create {
                $0.backgroundColor = UIColor.black.withAlphaComponent(0.55).cgColor
            }
            
            open lazy var bottomOverlay: CALayer = CALayer.create {
                $0.backgroundColor = UIColor.black.withAlphaComponent(0.55).cgColor
            }
            
            open lazy var leftOverlay: CALayer = CALayer.create {
                $0.backgroundColor = UIColor.black.withAlphaComponent(0.55).cgColor
            }
            
            open lazy var rightOverlay: CALayer = CALayer.create {
                $0.backgroundColor = UIColor.black.withAlphaComponent(0.55).cgColor
            }
            
            public override init(frame: CGRect) {
                super.init(frame: frame)
                self.layer.addSublayer(self.topOverlay)
                self.layer.addSublayer(self.bottomOverlay)
                self.layer.addSublayer(self.leftOverlay)
                self.layer.addSublayer(self.rightOverlay)
            }
            
            public required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
            }
            
            open override func layoutSubviews() {
                super.layoutSubviews()
                self.topOverlay.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 65.0)
                self.bottomOverlay.frame = CGRect(x: 0, y: self.bounds.height - 76.0, width: self.bounds.width, height: 76.0)
                self.leftOverlay.frame = CGRect(x: 0, y: 65.0, width: 1.0, height: self.bounds.height - ( 76 + 65 ))
                self.rightOverlay.frame = CGRect(x: self.bounds.width - 1.0, y: 65.0, width: 1.0, height: self.bounds.height - ( 76 + 65 ))
            }
            
        }
        
        open lazy var contentView: ContentViewClass = {
            [unowned self] in
            var _contentView: ContentViewClass = ContentViewClass()
            _contentView.translatesAutoresizingMaskIntoConstraints = false
            _contentView.layer.masksToBounds = true
            _contentView.layer.cornerRadius = 7.0
            
            let focusGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchFocus(_:)))
            _contentView.addGestureRecognizer(focusGesture)
            
            let zoomGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchToZoom(_:)))
            
            _contentView.addGestureRecognizer(zoomGesture)
            
            return _contentView
            }()
        
        open lazy var buttonToggle: UIButton = {
            [unowned self] in
            var _buttonToggle: UIButton = UIButton()
            _buttonToggle.translatesAutoresizingMaskIntoConstraints = false
            _buttonToggle.layer.masksToBounds = true
            
            _buttonToggle.setImage(UIImage(named: "photopicker_switch", in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: UIControlState())
            _buttonToggle.setImage(UIImage(named: "photopicker_switch", in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: .highlighted)
            _buttonToggle.setImage(UIImage(named: "photopicker_switch", in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: .selected)
            
            _buttonToggle.tintColor = UIColor.black
            _buttonToggle.imageEdgeInsets = UIEdgeInsets(top: 4.0, left: 2.0, bottom: 0.0, right: 2.0)
            _buttonToggle.setBackgroundImage(UIColor.gray.image, for: UIControlState())
            _buttonToggle.setBackgroundImage(UIColor.gray.image, for: .selected)
            _buttonToggle.setBackgroundImage(UIColor.lightGray.image, for: .highlighted)
            _buttonToggle.alpha = 0.75
            
            _buttonToggle.isEnabled = true
            _buttonToggle.layer.cornerRadius = self.buttonCornerRadius ?? DefaultAlertProperties.buttonCornerRadius
            _buttonToggle.addTarget(self, action: #selector(self.toggleCamera), for: .touchUpInside)
            return _buttonToggle
            }()
        
        open lazy var buttonFlash: UIButton = {
            [unowned self] in
            var _buttonFlash: UIButton = UIButton()
            _buttonFlash.translatesAutoresizingMaskIntoConstraints = false
            _buttonFlash.layer.masksToBounds = true
            
            _buttonFlash.setImage(self.flashImg(for: .auto).withRenderingMode(.alwaysTemplate), for: UIControlState())
            _buttonFlash.setImage(self.flashImg(for: .auto).withRenderingMode(.alwaysTemplate), for: .highlighted)
            _buttonFlash.setImage(self.flashImg(for: .auto).withRenderingMode(.alwaysTemplate), for: .selected)
            
            _buttonFlash.tintColor = UIColor.black
            _buttonFlash.imageEdgeInsets = UIEdgeInsets(top: 3.0, left: 2.0, bottom: 1.0, right: 2.0)
            _buttonFlash.setBackgroundImage(UIColor.gray.image, for: UIControlState())
            _buttonFlash.setBackgroundImage(UIColor.gray.image, for: .selected)
            _buttonFlash.setBackgroundImage(UIColor.lightGray.image, for: .highlighted)
            
            _buttonFlash.alpha = 0.75
            
            _buttonFlash.isEnabled = true
            _buttonFlash.layer.cornerRadius = self.buttonCornerRadius ?? DefaultAlertProperties.buttonCornerRadius
            _buttonFlash.addTarget(self, action: #selector(self.toggleFlash), for: .touchUpInside)
            return _buttonFlash
            }()
        
        open lazy var shootButton: CameraButton = {
            var _shootButton: CameraButton = CameraButton()
            _shootButton.translatesAutoresizingMaskIntoConstraints = false
            _shootButton.addTarget(self, action: #selector(self.shootCamera), for: .touchUpInside)
            _shootButton.alpha = 0.95
            return _shootButton
        }()
        
        open lazy var buttonCancel: UIButton = {
            [unowned self] in
            var _buttonCancel: UIButton = UIButton()
            _buttonCancel.translatesAutoresizingMaskIntoConstraints = false
            _buttonCancel.clipsToBounds = true
            
            _buttonCancel.setImage(UIImage(named: "photopicker_cancel", in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: UIControlState())
            _buttonCancel.setImage(UIImage(named: "photopicker_cancel", in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: .highlighted)
            _buttonCancel.setImage(UIImage(named: "photopicker_cancel", in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: .selected)
            
            _buttonCancel.tintColor = UIColor.black
            _buttonCancel.imageEdgeInsets = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
            _buttonCancel.setBackgroundImage(UIColor.gray.image, for: UIControlState())
            _buttonCancel.setBackgroundImage(UIColor.gray.image, for: .selected)
            _buttonCancel.setBackgroundImage(UIColor.lightGray.image, for: .highlighted)
            _buttonCancel.alpha = 0.75
            
            _buttonCancel.isEnabled = true
            _buttonCancel.layer.cornerRadius = self.buttonCornerRadius ?? DefaultAlertProperties.buttonCornerRadius
            _buttonCancel.addTarget(self, action: #selector(self.action_cancel), for: .touchUpInside)
            
            return _buttonCancel
            }()
        
        open lazy var buttonAlbum: UIButton = {
            [unowned self] in
            var _buttonAlbum: UIButton = UIButton()
            _buttonAlbum.translatesAutoresizingMaskIntoConstraints = false
            _buttonAlbum.clipsToBounds = true
            
            _buttonAlbum.setImage(UIImage(named: "photopicker_disk", in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: UIControlState())
            _buttonAlbum.setImage(UIImage(named: "photopicker_disk", in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: .highlighted)
            _buttonAlbum.setImage(UIImage(named: "photopicker_disk", in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)).withRenderingMode(.alwaysTemplate), for: .selected)
            
            _buttonAlbum.tintColor = UIColor.black
            _buttonAlbum.imageEdgeInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
            _buttonAlbum.setBackgroundImage(UIColor.gray.image, for: UIControlState())
            _buttonAlbum.setBackgroundImage(UIColor.gray.image, for: .selected)
            _buttonAlbum.setBackgroundImage(UIColor.lightGray.image, for: .highlighted)
            _buttonAlbum.alpha = 0.75
            
            _buttonAlbum.isEnabled = true
            _buttonAlbum.layer.cornerRadius = self.buttonCornerRadius ?? DefaultAlertProperties.buttonCornerRadius
            _buttonAlbum.addTarget(self, action: #selector(self.action_album), for: .touchUpInside)
            
            return _buttonAlbum
            }()
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.addSubview(self.contentView)
            
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
            self.addSubview(self.buttonCancel)
            self.buttonCancel.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -38.0).isActive = true
            self.buttonCancel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0).isActive = true
            
            self.addSubview(self.buttonAlbum)
            self.buttonAlbum.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -38.0).isActive = true
            self.buttonAlbum.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0).isActive = true
            
            self.addSubview(self.shootButton)
            self.shootButton.widthAnchor.constraint(equalToConstant: 66.0).isActive = true
            self.shootButton.heightAnchor.constraint(equalTo: self.shootButton.widthAnchor).isActive = true
            self.shootButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.shootButton.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -38.0).isActive = true
            
            self.addSubview(self.buttonFlash)
            self.buttonFlash.topAnchor.constraint(equalTo: self.topAnchor, constant: 6.0).isActive = true
            self.buttonFlash.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0).isActive = true
            
            self.addSubview(self.buttonToggle)
            self.buttonToggle.topAnchor.constraint(equalTo: self.topAnchor, constant: 6.0).isActive = true
            self.buttonToggle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0).isActive = true
            
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        open override func removeFromSuperview() {
            self.cameraController?.stop()
            super.removeFromSuperview()
        }
        
        open func initCamera(_ settings: PhotoPickerSettings? = nil) {
            
            guard self.cameraController == nil,
                AVCaptureDevice.authorizationStatus(for: .video) == .authorized
                else { return }
            
            let _cameraController: CameraController = CameraController()
            
            _cameraController.prepare {
                (error) in
                if let error = error { print(error) }
                
                try? _cameraController.displayPreview(on: self.contentView)
            }
            self.cameraController = _cameraController
            self.cameraController?.start()
            
            guard settings != nil else { return }
            
            if ( settings?.defaultCamera != self.currentCameraPosition ) {
                self.currentCameraPosition = settings?.defaultCamera ?? .rear
            }
            
            if (( settings?.flashMode != self.cameraController?.flashMode ) && ( self.cameraController?.availableFlashModes.contains(settings!.flashMode) ?? false )) {
                self.cameraController?.flashMode = settings!.flashMode
            }
            
        }
        
        open func enableCamera() {
            
            guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized else { return }
            
            self.initCamera()
            
            self.cameraController?.start()
            if (( self.currentCameraPosition != nil ) && ( self.cameraController?.currentCameraPosition != self.currentCameraPosition )) {
                try? self.cameraController?.switchCameras()
            }
            
            self.buttonFlash.isHidden = self.cameraController?.availableFlashModes.count ?? 0 < 2
            self.buttonFlash.setImage(self.flashImg(for: self.cameraController?.flashMode ?? .off).withRenderingMode(.alwaysTemplate), for: UIControlState())
            self.buttonFlash.setImage(self.flashImg(for: self.cameraController?.flashMode ?? .off).withRenderingMode(.alwaysTemplate), for: .highlighted)
            self.buttonFlash.setImage(self.flashImg(for: self.cameraController?.flashMode ?? .off).withRenderingMode(.alwaysTemplate), for: .selected)
            
            self.buttonToggle.isHidden = !(self.cameraController?.multipleCameras ?? false)
        }
        
        func disableCamera() {
            
            guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized else { return }
            
            self.currentCameraPosition = self.cameraController?.currentCameraPosition != nil ? self.cameraController?.currentCameraPosition : self.currentCameraPosition
            self.cameraController?.stop()
        }
        
        func flashImg(for: AVCaptureDevice.FlashMode?) -> UIImage {
            
            var imgName: String = "photopicker_flash_off"
            
            if ( `for` == .on ) { imgName = "photopicker_flash_on" }
            else if ( `for` == .auto ) { imgName = "photopicker_flash_auto" }
            
            return UIImage(named: imgName, in: Bundle(for: CameraView.self), compatibleWith: nil)?.scaled(to: CGSize(width: 52.0, height: 52.0)) ?? UIImage()
        }
        
        @objc func pinchToZoom(_ sender: UIPinchGestureRecognizer) {
            
            guard !(self.cameraController?.captureInProgress ?? true),
                let device = self.cameraController?.currentCamera
                else { return }
            
            if sender.state == .changed {
                
                let maxZoomFactor = device.activeFormat.videoMaxZoomFactor
                let pinchVelocityDividerFactor: CGFloat = 20.0
                
                do {
                    
                    try device.lockForConfiguration()
                    defer { device.unlockForConfiguration() }
                    
                    let desiredZoomFactor = device.videoZoomFactor + atan2(sender.velocity, pinchVelocityDividerFactor)
                    device.videoZoomFactor = max(1.0, min(desiredZoomFactor, maxZoomFactor))
                    
                } catch { }
            }
        }
        
        @objc func touchFocus(_ sender: UITapGestureRecognizer) {
            
            guard !(self.cameraController?.captureInProgress ?? true),
                let device = self.cameraController?.currentCamera
                else { return }
            
            do {
                try device.lockForConfiguration()
                defer { device.unlockForConfiguration() }
                
                if (( device.focusMode != .locked ) && ( device.isFocusModeSupported(.locked))) {
                    device.focusMode = .locked
                }
                
                device.focusPointOfInterest = sender.location(in: self.contentView)
                
            } catch { return }
        }
        
        @objc func action_album() {
            guard !(self.cameraController?.captureInProgress ?? true) else { return }
            self.album_handler?()
        }
        
        @objc func action_cancel() {
            guard !(self.cameraController?.captureInProgress ?? true) else { return }
            self.cancel_handler?()
        }
        
        @objc func shootCamera() {
            
            guard !(self.cameraController?.captureInProgress ?? true) else { return }
            
            self.cameraController?.captureImage {
                (image, error) in
                guard let image = image else {
                    print(error ?? "Image capture error")
                    return
                }
                
                self.shoot_handler?(image)
            }
        }
        
        @objc open func toggleFlash() {
            
            guard !(self.cameraController?.captureInProgress ?? true),
                self.cameraController?.availableFlashModes.count ?? 0 > 1
                else { return }
            
            try? self.cameraController?.toggleFlashMode()
            
            self.buttonFlash.setImage(self.flashImg(for: self.cameraController?.flashMode ?? .off).withRenderingMode(.alwaysTemplate), for: UIControlState())
            self.buttonFlash.setImage(self.flashImg(for: self.cameraController?.flashMode ?? .off).withRenderingMode(.alwaysTemplate), for: .highlighted)
            self.buttonFlash.setImage(self.flashImg(for: self.cameraController?.flashMode ?? .off).withRenderingMode(.alwaysTemplate), for: .selected)
        }
        
        @objc open func toggleCamera() {
            
            guard !(self.cameraController?.captureInProgress ?? true),
                self.cameraController?.multipleCameras ?? false
                else { return }
            
            try? self.cameraController?.switchCameras()
        }
        
    }
    
}
