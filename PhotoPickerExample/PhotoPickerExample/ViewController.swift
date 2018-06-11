//
//  ViewController.swift
//  PhotoPickerExample
//
//  Created by Oskari Rauta on 12/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit
import CommonKit

class ViewController: UIViewController {

    lazy var photoPicker: PhotoPicker = PhotoPicker()
    
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

}

