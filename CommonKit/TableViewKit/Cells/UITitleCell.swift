//
//  UITitleCell.swift
//  ComponentKit
//
//  Created by Oskari Rauta on 25/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    open class TitleCell: UITableViewCell.Extended, CellTitle {
     
           open lazy var titleLabel: UITitleLabel = UITitleLabel.´default´.properties {
               $0.translatesAutoresizingMaskIntoConstraints = false
               $0.textColor = self.enabled ? self.titleColor : self.disabledColor
               $0.iconColor = self.enabled ? ( self.iconColor ?? self.titleColor ) : self.disabledColor
               $0.iconSize = UIDevice.deviceFamily.iphoneCompatible ? 16.5 : 33.0
               $0.iconWidthSource = .manual( UIDevice.deviceFamily.iphoneCompatible ? 19.5 : 39.0 )
               $0.iconMargin = UIDevice.deviceFamily.iphoneCompatible ? 2.0 : 4.0
               $0.font = UIFont.boldSystemFont(ofSize: UIDevice.deviceFamily.iphoneCompatible ? 13.5: 27.0 )
               $0.text = ""
               $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
           }
           
           open var titleColor: UIColor! = UIColor.defaultTitleColor {
               didSet {
                   self.titleLabel.titleColor = self.enabled ? self.titleColor : self.disabledColor
                   self.titleLabel.iconColor = self.iconColor != nil ? ( self.enabled ? self.iconColor! : self.disabledColor ) : nil
               }
           }
           
           open var disabledColor: UIColor! = UIColor.disabledColor {
               didSet {
                   self.titleLabel.titleColor = self.enabled ? self.titleColor : self.disabledColor
                   self.titleLabel.iconColor = self.iconColor != nil ? ( self.enabled ? self.iconColor! : self.disabledColor ) : nil
               }
           }
           
           open var italic: Bool {
               get { return self.titleFont.fontDescriptor.symbolicTraits.contains(.traitItalic) }
               set { self.titleLabel.font = self.titleFont.fontDescriptor.symbolicTraits.contains(.traitItalic) ? UIFont.italicSystemFont(ofSize: self.titleLabel.font.pointSize) : UIFont.boldSystemFont(ofSize: self.titleLabel.font.pointSize) }
           }
           
           open var titleFont: UIFont! {
               get { return self.titleLabel.titleFont }
               set {
                   self.italic = newValue.fontDescriptor.symbolicTraits.contains(.traitItalic)
                   self.titleLabel.titleFont = newValue
               }
           }
           
           open var iconColor: UIColor? = nil {
               didSet {
                   self.titleLabel.textColor = self.enabled ? self.titleColor : self.disabledColor
                   self.titleLabel.iconColor = self.iconColor != nil ? ( self.enabled ? self.iconColor! : self.disabledColor ) : nil
               }
           }
           
           override open var enabled: Bool {
               didSet {
                   self.titleLabel.textColor = self.enabled ? self.titleColor : self.disabledColor
                   self.titleLabel.iconColor = self.iconColor != nil ? ( self.enabled ? self.iconColor! : self.disabledColor ) : nil
               }
           }
           
           override open func cellProperties() {
               super.cellProperties()
               self.selectable = false
               self.enabled = true
               self.titleColor = UIColor.defaultTitleColor
               self.disabledColor = UIColor.disabledColor
               self.iconColor = nil
               self.titleLabel.iconWidthSource = .manual( UIDevice.deviceFamily.iphoneCompatible ? 19.5 : 39.0 )
               self.titleFont = UIFont.boldSystemFont(ofSize: UIDevice.deviceFamily.iphoneCompatible ? 13.5 : 27.0)
               self.titleLabel.padding = nil
               self.icon = nil
               self.title = nil
               self.iconSize = UIDevice.deviceFamily.iphoneCompatible ? 16.5 : 33.0
               self.iconMargin = UIDevice.deviceFamily.iphoneCompatible ? 2.0 : 4.0
               self.accessoryType = .none
               self.editingAccessoryType = .none
               self.shouldIndentWhileEditing = true
               self.selectionStyle = .none
               self.accessoryType = .none
               self.focusStyle = .default
               self.handler = nil
           }
           
           override open func setupViews() {
               super.setupViews()
               self.contentView.addSubview(self.titleLabel)
               
               self.titleLabel.textColor = self.enabled ? self.titleColor : self.disabledColor
               self.titleLabel.iconColor = self.iconColor != nil ? ( self.enabled ? self.iconColor! : self.disabledColor ) : nil
           }
           
           override open func setupConstraints() {
               super.setupConstraints()
               
               self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0).isActive = true
               
               self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
               self.titleLabel.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: 8.0).isActive = true
               self.titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -8.0).isActive = true
           }
           
           open override func secondaryConstraints() {
               
               self.cellConstraints["titleLabel-trailing"] = self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0)
           }
        
           open override func returnValues() -> CellReturn {
               return CellReturn(cell: self, values: self.title ?? "")
           }
         
           open func internalSetSelected(_ selected: Bool, animated: Bool) {
               
               guard self.handler != nil, !self.isEditing, self.selectable, self.enabled, selected else { return }
               
               if ( self.tableView?.isEditing ?? false ) {
                   self.controllerProtocol?.endEditing()
               }
               
               self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
               self.titleLabel.textColor = UIColor.lightText
               
               UIView.animate(withDuration: 0.45, animations: {
                   self.backgroundColor = UIColor.cellBackgroundColor
                   self.titleLabel.textColor = self.titleColor
               })
               
               self.handler?(self.returnValues())
           }

    }
    
}
