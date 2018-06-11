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
    
    lazy var photoPicker: PhotoPicker = {
        [unowned self] in
        var _photoPicker: PhotoPicker = PhotoPicker()
        _photoPicker.photo_handler = self.photosHandler
        _photoPicker.camera_handler = self.cameraHandler
        return _photoPicker
    }()
    
    lazy var imageView: UIImageView = UIImageView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var button: UIButton = UIButton.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Select photo", for: UIControlState())
        $0.tag = 0
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        $0.setTitleColor(UIColor.buttonForegroundColor, for: UIControlState())
        $0.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        $0.addTarget(self, action: #selector(self.pickPhoto(_:)), for: .touchUpInside)
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
        
        self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 35.0).isActive = true
        self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        
        self.button.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 35.0).isActive = true
        self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }

    @objc func pickPhoto(_ sender: Any) {
        self.present(self.photoPicker, animated: true, completion: nil)
    }

    @objc func photosHandler(_ photos: [PHAsset]) {
        print("Chose " + photos.count.description + " photos.")
        if let asset = photos.last {
            self.photoPicker.photoManager.requestImage(for: asset, targetSize: CGSize(width: 80.0, height: 80.0), contentMode: .aspectFit, options: self.requestOptions, resultHandler: {(result, info)->Void in
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

