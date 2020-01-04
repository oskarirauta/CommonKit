//
//  ViewController.swift
//  PhotoPickerExample
//
//  Created by Oskari Rauta on 12/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit
import CommonKit
import Photos

class ViewController: UIViewController {
    
    var photoPicker: PhotoPicker? = nil
        
    lazy var imageView: UIImageView = UIImageView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var button: UIButton = UIButton.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Select photo", for: UIControl.State())
        $0.tag = 0
        $0.isHidden = true
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.5)
        $0.setTitleColor(UIColor.link, for: UIControl.State())
        $0.setTitleColor(UIColor.lightText, for: UIControl.State.highlighted)
        $0.addTarget(self, action: #selector(self.pickPhoto(_:)), for: .touchUpInside)
    }

    lazy var noAccessLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Photo library authorization required."
        $0.font = UIFont.boldSystemFont(ofSize: 14.5)
        $0.isHidden = false
    }
    
    lazy var requestOptions: PHImageRequestOptions = PHImageRequestOptions().properties {
        $0.resizeMode = .fast
        $0.deliveryMode = .fastFormat
        $0.isNetworkAccessAllowed = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.button)
        self.view.addSubview(self.noAccessLabel)
        
        self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 35.0).isActive = true
        self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        
        self.button.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 35.0).isActive = true
        self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.noAccessLabel.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 20.0).isActive = true
        self.noAccessLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        let cameras = session.devices.compactMap { $0 }
        let hasCamera: Bool = !cameras.isEmpty
        
        if ( hasCamera ) {
            AVCaptureDevice.requestAccess(for: AVMediaType.video) {
                response in
                print(response ? "Camera access granted" : "Camera access not allowed.")
            }
        }

        let photos = PHPhotoLibrary.authorizationStatus()
        if ( photos != .authorized ) {
            PHPhotoLibrary.requestAuthorization {
                status in
                if ( status == .authorized ) {
                    DispatchQueue.main.async {
                        self.button.isHidden = false
                        self.noAccessLabel.isHidden = true
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.button.isHidden = false
                self.noAccessLabel.isHidden = true
            }
        }
    }
    
    @objc func pickPhoto(_ sender: Any) {
        let _photoPicker: PhotoPicker = PhotoPicker()
        _photoPicker.photo_handler = self.photosHandler
        _photoPicker.camera_handler = self.cameraHandler
        self.photoPicker = _photoPicker

        self.present(self.photoPicker!, animated: true, completion: nil)
    }

    @objc func photosHandler(_ photos: [PHAsset]) {
        print("Chose " + photos.count.description + " photos.")
        if let asset = photos.last {
            self.photoPicker?.photoManager.requestImage(for: asset, targetSize: CGSize(width: 80.0, height: 80.0), contentMode: .aspectFit, options: self.requestOptions, resultHandler: {(result, info)->Void in
                self.imageView.image = result!
            })
        }
    }
    
    @objc func cameraHandler(_ image: UIImage?) {
        print("Photo from camera")
        if let image: UIImage = image {
            self.imageView.image = image
        } else { self.imageView.image = nil }
    }

}

