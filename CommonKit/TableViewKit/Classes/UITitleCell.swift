//
//  UITitleCell.swift
//  ComponentKit
//
//  Created by Oskari Rauta on 25/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class UITitleCell: UITableViewCellExtended, CellTitleProtocol {
            
    open lazy var titleLabel: UITitleLabel = UITitleLabel.´default´.properties {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = self.enabled ? self.titleColor : UIColor.gray
        $0.iconColor = self.enabled ? ( self.iconColor ?? self.titleColor ) : UIColor.gray
        $0.iconSize = 16.5
        $0.iconWidthSource = .manual(19.5)
        $0.font = UIFont.boldSystemFont(ofSize: 13.5)
        $0.text = ""
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    open var titleColor: UIColor! = UIColor.defaultTitleColor {
        didSet {
            self.titleLabel.titleColor = self.enabled ? self.titleColor : UIColor.gray
            self.titleLabel.iconColor = self.iconColor != nil ? ( self.enabled ? self.iconColor! : UIColor.gray ) : nil
        }
    }
    
    open var italic: Bool {
        get { return self.titleFont.fontDescriptor.symbolicTraits.contains(.traitItalic) }
        set { self.titleLabel.font = self.italic ? UIFont.italicSystemFont(ofSize: self.titleLabel.font.pointSize) : UIFont.boldSystemFont(ofSize: self.titleLabel.font.pointSize) }
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
            self.titleLabel.textColor = self.enabled ? self.titleColor : UIColor.gray
            self.titleLabel.iconColor = self.iconColor != nil ? ( self.enabled ? self.iconColor! : UIColor.gray ) : nil
        }
    }
    
    override open var enabled: Bool {
        didSet {
            self.titleLabel.textColor = self.enabled ? self.titleColor : UIColor.gray
            self.titleLabel.iconColor = self.iconColor != nil ? ( self.enabled ? self.iconColor! : UIColor.gray ) : nil
        }
    }
    
    override open func cellProperties() {
        super.cellProperties()
        self.selectable = false
        self.enabled = true
        self.titleColor = UIColor.black
        self.iconColor = nil
        self.titleLabel.iconWidthSource = .manual(19.5)
        self.titleFont = UIFont.boldSystemFont(ofSize: 13.5)
        self.titleLabel.padding = nil
        self.icon = nil
        self.title = nil
        self.iconSize = 16.5
        self.iconMargin = 2.0
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
        
        self.titleLabel.textColor = self.enabled ? self.titleColor : UIColor.gray
        self.titleLabel.iconColor = self.iconColor != nil ? ( self.enabled ? self.iconColor! : UIColor.gray ) : nil
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
        self.titleLabel.textColor = UIColor.white
        
        UIView.animate(withDuration: 0.45, animations: {
            self.backgroundColor = UIColor.cellBackgroundColor
            self.titleLabel.textColor = self.titleColor
        })
        
        self.handler?(self.returnValues())
    }

}
