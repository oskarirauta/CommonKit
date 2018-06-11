//
//  PhotoPickerView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit
import Photos

open class PhotoPickerView: AlertView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Settings
    open var cellSpacing: CGFloat { get { return 6.0 }}
    open var cellsInRow: Int { get { return 3 }}
    
    open var cancel_handler: (() -> Void)? = nil
    open var accept_photos_handler: (() -> Void)? = nil
    open var accept_camera_photo_handler: (() -> Void)? = nil
    
    fileprivate var _settings: PhotoPickerSettings? = nil
    
    open var settings: PhotoPickerSettings {
        get { return self._settings ?? PhotoPickerSettings() }
    }
    
    open lazy var assetManager: AssetManager = AssetManager(size: self.cellSize)
    
    open lazy var photoManager: PHImageManager = PHImageManager.default()
    
    open lazy var photoView: PhotoView = PhotoView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.album_handler = self.showAlbumSelector
        $0.camera_handler = self.showCamera
        $0.accept_handler = self.acceptPhotos
        $0.cancel_handler = self.cancel
        $0.albumTitle = self.assetManager.currentAlbum?.name
        $0.delegate = self
        $0.datasource = self
        $0.isHidden = false
    }
    
    open lazy var photoPreviewView: PhotoPreviewView = PhotoPreviewView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        $0.back_handler = self.dismissPhotoPreview
    }
    
    open lazy var albumView: AlbumView = AlbumView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.cancel_handler = self.dismissAlbumSelector
        $0.delegate = self
        $0.datasource = self
        $0.isHidden = true
    }
    
    open lazy var cameraView: CameraView = CameraView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        $0.album_handler = self.dismissCamera
        $0.shoot_handler = self.showPreview
        $0.cancel_handler = self.cancel
        $0.initCamera(self._settings)
    }
    
    open lazy var previewView: PreviewView = PreviewView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        $0.cancel_handler = self.dismissPreview
        $0.accept_handler = self.acceptPreview
    }
    
    open var cellSize: CGSize {
        get {
            let width: CGFloat = self.frame.size.width < self.frame.size.height ? self.frame.size.width : self.frame.size.height
            let _cellSize: CGFloat = (( width - 18.0 ) / CGFloat(self.cellsInRow)) - ( self.cellSpacing * 0.8 )
            return CGSize(width: _cellSize, height: _cellSize)
        }
    }
    
    open var selectedAssetIndexes: Array<Int> = []
    
    open var hasCamera: Bool {
        get { return true }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraints()
    }
    
    public init(settings: PhotoPickerSettings) {
        super.init(frame: CGRect.zero)
        self._settings = settings
        self.setupView()
        self.setupConstraints()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func setupView() {
        
        self.addSubview(self.photoView)
        self.addSubview(self.albumView)
        self.addSubview(self.photoPreviewView)
        self.addSubview(self.cameraView)
        self.addSubview(self.previewView)
    }
    
    open func setupConstraints() {
        
        self.photoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0).isActive = true
        self.photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6.0).isActive = true
        self.photoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6.0).isActive = true
        self.photoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6.0).isActive = true
        
        self.albumView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0).isActive = true
        self.albumView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6.0).isActive = true
        self.albumView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6.0).isActive = true
        self.albumView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6.0).isActive = true
        
        self.photoPreviewView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.photoPreviewView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.photoPreviewView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.photoPreviewView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.cameraView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.cameraView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.cameraView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.cameraView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.previewView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.previewView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.previewView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.previewView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    open func reset() {
        self.assetManager = AssetManager(size: self.cellSize)
        self.selectedAssetIndexes.removeAll()
        self.albumCollection.reloadData()
        self.photoCollection.reloadData()
        
        self.previewView.image = nil
        
        if (( !self.previewView.isHidden) || ( !self.cameraView.isHidden )) {
            self.cameraView.isHidden = false
            self.previewView.isHidden = true
            self.albumView.isHidden = true
            self.photoView.isHidden = true
        } else {
            self.photoView.isHidden = false
            self.cameraView.isHidden = true
            self.previewView.isHidden = true
            self.albumView.isHidden = true
        }
    }
    
    open func showPhotoPreview(_ indexPath: IndexPath) {
        
        self.photoPreviewView.image = nil
        
        let requestOptions: PHImageRequestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = .fast
        requestOptions.deliveryMode = .fastFormat
        requestOptions.isNetworkAccessAllowed = false
        
        self.photoManager.requestImageData(for: self.assetManager.currentAlbum!.assets.object(at: indexPath.row), options: requestOptions, resultHandler: {
            (data, str, orientation, info) -> Void in
            if ( data != nil ) {
                self.photoPreviewView.image = UIImage(data: data!)
            }
        })
        
        let options: UIViewAnimationOptions = [
            UIViewAnimationOptions.showHideTransitionViews,
            UIViewAnimationOptions.transitionFlipFromLeft
        ]
        UIView.transition(from: self.photoView, to: self.photoPreviewView, duration: 0.4, options: options, completion: nil)
        
    }
    
    open func dismissPhotoPreview() {
        
        let options: UIViewAnimationOptions = [
            UIViewAnimationOptions.showHideTransitionViews,
            UIViewAnimationOptions.transitionFlipFromRight
        ]
        
        UIView.transition(from: self.photoPreviewView, to: self.photoView, duration: 0.4, options: options, completion: nil)
    }
    
    
    open func showAlbumSelector() {
        
        // guard self.assetManager.albums.count > 1 else { return }
        
        let options: UIViewAnimationOptions = [
            UIViewAnimationOptions.showHideTransitionViews,
            UIViewAnimationOptions.transitionFlipFromLeft
        ]
        UIView.transition(from: self.photoView, to: self.albumView, duration: 0.4, options: options, completion: nil)
    }
    
    open func dismissAlbumSelector() {
        
        let options: UIViewAnimationOptions = [
            UIViewAnimationOptions.showHideTransitionViews,
            UIViewAnimationOptions.transitionFlipFromRight
        ]
        
        UIView.transition(from: self.albumView, to: self.photoView, duration: 0.4, options: options, completion: nil)
    }
    
    open func showCamera() {
        
        self.cameraView.enableCamera()
        
        let options: UIViewAnimationOptions = [
            UIViewAnimationOptions.showHideTransitionViews,
            UIViewAnimationOptions.transitionFlipFromLeft
        ]
        
        UIView.transition(from: self.photoView, to: self.cameraView, duration: 0.4, options: options, completion: nil)
    }
    
    open func dismissCamera() {
        
        self.cameraView.disableCamera()
        
        let options: UIViewAnimationOptions = [
            UIViewAnimationOptions.showHideTransitionViews,
            UIViewAnimationOptions.transitionFlipFromRight
        ]
        
        UIView.transition(from: self.cameraView, to: self.photoView, duration: 0.4, options: options, completion: nil)
        
    }
    
    open func showPreview(image: UIImage) {
        
        self.previewView.image = image
        
        let options: UIViewAnimationOptions = [
            UIViewAnimationOptions.showHideTransitionViews,
            UIViewAnimationOptions.transitionFlipFromLeft
        ]
        
        UIView.transition(from: self.photoView, to: self.previewView, duration: 0.4, options: options, completion: nil)
    }
    
    open func dismissPreview() {
        
        self.cameraView.enableCamera()
        
        let options: UIViewAnimationOptions = [
            UIViewAnimationOptions.showHideTransitionViews,
            UIViewAnimationOptions.transitionFlipFromRight
        ]
        
        UIView.transition(from: self.previewView, to: self.cameraView, duration: 0.4, options: options, completion: nil)
    }
    
    open func reload() {
        let selectedAlbum: Int = self.assetManager.albumIndex
        self.selectedAssetIndexes.removeAll()
        self.assetManager = AssetManager(size: self.cellSize)
        self.assetManager.albumIndex = selectedAlbum < self.assetManager.albums.count ? selectedAlbum : 0
        self.photoCollection.reloadData()
    }
    
    open func cancel() {
        self.cancel_handler?()
    }
    
    open func acceptPhotos() {
        if ( self._settings == nil ) { self._settings = PhotoPickerSettings() }
        self._settings?.defaultView = .photos
        
        guard self.selectedAssetIndexes.count != 0 else { return }
        self.accept_photos_handler?()
    }
    
    open func acceptPreview() {
        if ( self._settings == nil ) { self._settings = PhotoPickerSettings() }
        self._settings?.defaultView = .camera
        self._settings?.defaultCamera = self.cameraView.cameraController?.currentCameraPosition ?? .rear
        self._settings?.flashMode = self.cameraView.cameraController?.flashMode ?? .auto
        
        self.accept_camera_photo_handler?()
    }
    
}
