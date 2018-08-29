//
//  PhotoCell.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension PhotoPickerView {
    
    open class PhotoCell: UICollectionViewCell {
        
        open var image: UIImage? {
            get { return self.imageView.image }
            set { self.imageView.image = newValue }
        }
        
        open var number: Int? = nil {
            didSet {
                guard self.number != oldValue else { return }
                if ( oldValue == nil ) { self.label.isHidden = false }
                if ( self.number == nil ) {
                    self.label.isHidden = true
                    self.label.text = nil
                } else {
                    self.label.text = String(self.number! + 1)
                }
            }
        }

        open lazy var label: UILabelExtended = UILabelExtended.create {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.isHidden = true
            $0.font = UIFont(name: "HelveticaNeue-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14)
            $0.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.95)
            $0.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
            $0.padding = UIEdgeInsets(top: 0.0, left: 4.0, bottom: 0.5, right: 3.5)
            $0.textAlignment = .center
            $0.alpha = 0.88
        }
        
        open lazy var imageView: UIImageView = UIImageView.create {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        open lazy var tapAct: UITapGestureRecognizer = {
            var _tapAct: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))
            return _tapAct
        }()
        
        open lazy var longTapAct: UILongPressGestureRecognizer = {
            var _longTapAct: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longTapAction))
            return _longTapAct
        }()
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.contentView.addSubview(self.imageView)
            self.contentView.addSubview(self.label)
            self.contentView.bringSubview(toFront: self.label)
            
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            self.label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            self.label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
            
            self.contentView.layer.cornerRadius = 4.0
            self.contentView.layer.masksToBounds = true
            self.contentView.clipsToBounds = true
            
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
            self.layer.shadowRadius = 3.0
            self.layer.shadowOpacity = 0.7
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
            
            self.addGestureRecognizer(self.tapAct)
            self.addGestureRecognizer(self.longTapAct)
            
        }
        
        public required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        open override func prepareForReuse() {
            self.image = nil
            self.number = nil
        }
        
        @objc open func tapAction() {
            
            if let collectionView = self.superview as? UICollectionView {
                if let controller = collectionView.delegate as? PhotoPickerView {
                    
                    guard !controller.photoView.isHidden else { return }
                    
                    if let indexPath = collectionView.indexPath(for: self) {
                        
                        if let index: Int = controller.selectedAssetIndexes.index(of: indexPath.row) {
                            controller.selectedAssetIndexes.remove(at: index)
                        } else {
                            controller.selectedAssetIndexes.append(indexPath.row)
                        }
                        
                        for cell in collectionView.visibleCells as! [PhotoCell] {
                            cell.number = controller.selectedAssetIndexes.index(of: cell.tag)
                        }
                    }
                }
            }
            
        }
        
        @objc open func longTapAction() {
            
            if let collectionView = self.superview as? UICollectionView {
                if let controller = collectionView.delegate as? PhotoPickerView {
                    
                    guard !controller.photoView.isHidden else { return }
                    
                    if let indexPath = collectionView.indexPath(for: self) {
                        controller.showPhotoPreview(indexPath)
                    }
                }
            }
        }
        
    }
    
}
