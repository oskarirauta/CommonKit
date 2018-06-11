//
//  AlbumView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension PhotoPickerView {
    
    open var albumCollection: UICollectionView {
        get { return self.albumView.collectionView }
        set { self.albumView.collectionView = newValue }
    }
    
    open class AlbumView: AlertView {
                
        open var delegate: UICollectionViewDelegate? {
            get { return self.collectionView.delegate }
            set { self.collectionView.delegate = newValue }
        }
        
        open var datasource: UICollectionViewDataSource? {
            get { return self.collectionView.dataSource }
            set { self.collectionView.dataSource = newValue }
        }
        
        open var cancel_handler: (() -> ())? = nil

        open lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).properties {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = UIColor.clear
            $0.isScrollEnabled = true
            $0.scrollsToTop = true
            $0.bounces = true
            $0.tag = 1
            $0.contentInset = UIEdgeInsetsMake(5.0, 3.0, 3.0, 3.0)
            $0.register(AlbumCell.self, forCellWithReuseIdentifier: "albumCell")
        }
        
        open lazy var buttonArea: UIView = {
            [unowned self] in
            var _buttonArea: UIView = UIView()
            _buttonArea.translatesAutoresizingMaskIntoConstraints = false
            
            _buttonArea.addSubview(self.buttonCancel)
            return _buttonArea
            }()
        
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
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            self.addSubview(self.collectionView)
            self.addSubview(self.buttonArea)
            
            // Constraints
            
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2.0).isActive = true
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            
            self.buttonArea.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: -8.0).isActive = true
            self.buttonArea.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.buttonArea.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.buttonArea.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            
            self.buttonCancel.topAnchor.constraint(equalTo: self.buttonArea.topAnchor).isActive = true
            self.buttonCancel.bottomAnchor.constraint(equalTo: self.buttonArea.bottomAnchor).isActive = true
            self.buttonCancel.heightAnchor.constraint(equalToConstant: self.buttonHeight ?? DefaultAlertProperties.buttonHeight).isActive = true
            self.buttonCancel.leadingAnchor.constraint(equalTo: self.buttonArea.leadingAnchor).isActive = true
            self.buttonCancel.widthAnchor.constraint(equalToConstant: self.buttonCancel.intrinsicContentSize.width + ( 2 * 15.0 )).isActive = true
            
        }
        
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        @objc open func action_cancel(_ sender: AnyObject) {
            self.cancel_handler?()
        }
        
        
    }
    
}
