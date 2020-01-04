//
//  PhotoPicker.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AVFoundation

public enum InitialPhotoPickerView: Int {
    case photos = 0
    case camera = 1
}

public struct PhotoPickerSettings {
    var defaultView: InitialPhotoPickerView = .photos
    var defaultCamera: CameraController.CameraPosition = .rear
    var flashMode: AVCaptureDevice.FlashMode = AVCaptureDevice.FlashMode.off
}

open class PhotoPicker: DefaultAlertControllerBaseClass, PHPhotoLibraryChangeObserver {
        
    open var photo_handler: ((Array<PHAsset>) -> Void)? = nil
    open var camera_handler: ((UIImage?) -> Void)? = nil
    open var dismiss_handler: ((PhotoPicker) -> Void)? = nil
    open var cancel_handler: (() -> Void)? = nil
    
    open var settings: PhotoPickerSettings {
        get { return self.photoPickerView.settings }
    }
    fileprivate var _settings: PhotoPickerSettings? = nil
    
    open override var fullscreen: Bool {
        get { return true }
    }

    open lazy var photoPickerView: PhotoPickerView = PhotoPickerView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.cancel_handler = self.cancel
        $0.accept_photos_handler = self.accept_photos
        $0.accept_camera_photo_handler = self.accept_camera_photo
    }
    
    public var assetManager: AssetManager {
        get { return self.photoPickerView.assetManager }
    }
    
    public var photoManager: PHImageManager {
        get { return self.photoPickerView.photoManager }
    }
    
    open override func setupView() {
        super.setupView()
        self.contentView.addSubview(self.photoPickerView)
    }
    
    open override func setupConstraints() {
        
        super.setupConstraints()
        
        self.photoPickerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0.0).isActive = true
        self.photoPickerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0.0).isActive = true
        self.photoPickerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0.0).isActive = true
        self.photoPickerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0.0).isActive = true
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
        PHPhotoLibrary.shared().register(self)
        self._settings = PhotoPickerSettings()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init() {
        super.init(nibName: nil, bundle: nil)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overCurrentContext
        self.setupNotifications()
        self.title = nil
        self._preferredStyle = .alert
        self.setupView()
        self.setupConstraints()
        PHPhotoLibrary.shared().register(self)
        self._settings = PhotoPickerSettings()
    }
    
    public init(settings: PhotoPickerSettings?) {
        super.init(nibName: nil, bundle: nil)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overCurrentContext
        self.setupNotifications()
        self.title = nil
        self._preferredStyle = .alert
        self.setupView()
        self.setupConstraints()
        PHPhotoLibrary.shared().register(self)
        self._settings = settings ?? PhotoPickerSettings()
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.photoPickerView.albumView.isHidden = true
        self.photoPickerView.previewView.isHidden = true
        self.photoPickerView.photoPreviewView.isHidden = true
        
        if ( self._settings?.defaultView == .photos ) {
            self.photoPickerView.cameraView.isHidden = true
            self.photoPickerView.photoView.isHidden = false
        } else {
            self.photoPickerView.cameraView.isHidden = false
            self.photoPickerView.photoView.isHidden = true
        }
        
        let hasCamera: Bool = UIImagePickerController.isSourceTypeAvailable(.camera)
        let _ = self.photoPickerView.photoView.buttonArea
        
        if (( AVCaptureDevice.authorizationStatus(for: .video) == .authorized ) && ( hasCamera )) {
            
            if ( self.photoPickerView.photoView.buttonCamera.superview == nil ) {
                self.photoPickerView.photoView.buttonArea.addSubview(self.photoPickerView.photoView.buttonCamera)
            }
        } else {
            
            if ( !self.photoPickerView.cameraView.isHidden ) {
                self.photoPickerView.cameraView.isHidden = true
                self.photoPickerView.photoView.isHidden = false
                self._settings?.defaultView = .photos
            }
            
            if ( self.photoPickerView.photoView.buttonCamera.superview != nil ) {
                self.photoPickerView.photoView.buttonCamera.removeFromSuperview()
            }
        }
        
    }
    
    open func photoLibraryDidChange(_ changeInstance: PHChange) {
        self.photoPickerView.reload()
    }
    
    open func cancel() {
        self.dismiss(animated: true, completion: nil)
        self.photoPickerView.cameraView.disableCamera()
        self.photoPickerView.reset()
        self.cancel_handler?()
        self.dismiss_handler?(self)
    }
    
    open func accept_camera_photo() {
        self.dismiss(animated: true, completion: nil)
        self.photoPickerView.reset()
        self.camera_handler?(self.photoPickerView.previewView.image)
        self.photoPickerView.cameraView.disableCamera()
        self.dismiss_handler?(self)
    }
    
    open func accept_photos() {
        self.dismiss(animated: true, completion: nil)
        self.photoPickerView.cameraView.disableCamera()
        var photoArray: Array<PHAsset> = []
        for index in self.photoPickerView.selectedAssetIndexes {
            photoArray.append(self.photoPickerView.assetManager.currentAlbum!.assets.object(at: index))
        }
        self.photoPickerView.reset()
        if ( photoArray.count > 0 ) {
            self.photo_handler?(photoArray)
        }
        self.dismiss_handler?(self)
    }
    
}
