//
//  UIHeaderFooterViewExtended.swift
//  CommonKit
//
//  Created by Oskari Rauta on 14/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class UIHeaderFooterViewExtended: UITableViewHeaderFooterView, HeaderConstraintProtocol, HeaderTitleProtocol {
    
    open lazy var titleLabel: UITitleLabel = UITitleLabel.´default´.properties {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.baselineAdjustment = .alignBaselines
        $0.lineBreakMode = .byTruncatingTail
        $0.adjustsFontSizeToFitWidth = false
        $0.textAlignment = .left
        $0.textColor = self.titleColor
        $0.iconColor = self.iconColor
        $0.iconSize = 16.0
        $0.iconWidthSource = .manual(18.5)
        $0.font = UIFont.systemFont(ofSize: 13.4)
        $0.text = ""
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    open var titleColor: UIColor! = UIColor.darkGray {
        didSet {
            self.titleLabel.titleColor = self.titleColor
            self.titleLabel.iconColor = self.iconColor
        }
    }
    
    open var italic: Bool = false {
        didSet {
            self.titleLabel.font = self.italic ? UIFont.italicSystemFont(ofSize: self.titleLabel.font.pointSize) : UIFont.boldSystemFont(ofSize: self.titleLabel.font.pointSize)
        }
    }
    
    open var titleFont: UIFont! {
        get { return self.titleLabel.titleFont }
        set {
            self.italic = newValue.fontDescriptor.symbolicTraits.contains(.traitItalic)
            self.titleLabel.titleFont = newValue
        }
    }
    
    open var iconColor: UIColor? = UIColor.darkGray {
        didSet {
            self.titleLabel.textColor = self.titleColor
            self.titleLabel.iconColor = self.iconColor
        }
    }
    
    open var fixedTitleHeight: CGFloat? = nil {
        didSet {
            self.headerConstraints["titleLabel-height"]?.isActive = false
            guard self.fixedTitleHeight != nil else {
                self.headerConstraints.removeValue(forKey: "titleLabel-height")
                self.setNeedsUpdateConstraints()
                return
            }
            self.headerConstraints["titleLabel-height"] = self.titleLabel.heightAnchor.constraint(equalToConstant: self.fixedTitleHeight!)
            self.headerConstraints["titleLabel-height"]?.isActive = true
            self.setNeedsUpdateConstraints()
        }
    }
    
    open var headerConstraints: HeaderConstraints = [:]
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tableView = nil
        self.headerProperties()
        self.setupViews()
        self.secondarySetupViews()
        self.setupConstraints()
        self.secondaryConstraints()
        (self as HeaderConstraintProtocol).updateHeaderConstraints?()
        self.activateHeaderConstraints()
        self.setNeedsUpdateConstraints()
    }
    
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.tableView = nil
        self.headerProperties()
        self.setupViews()
        self.secondarySetupViews()
        self.setupConstraints()
        self.secondaryConstraints()
        (self as HeaderConstraintProtocol).updateHeaderConstraints?()
        self.activateHeaderConstraints()
        self.setNeedsUpdateConstraints()
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        self.headerProperties()
    }
    
    override open func setupViews() {
        super.setupViews()
        self.contentView.addSubview(self.titleLabel)
        
        self.titleLabel.textColor = self.titleColor
        self.titleLabel.iconColor = self.iconColor
    }
    
    override open func setupConstraints() {
        super.setupConstraints()
        
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0).isActive = true

        self.titleLabel.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: 8.0).isActive = true

        self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5.0).isActive = true        
    }
    
    open override func secondaryConstraints() {
        
        self.headerConstraints["titleLabel-trailing"] = self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -4.0).withPriority(999)
        
        if ( self.fixedTitleHeight != nil ) {
            self.headerConstraints["titleLabel-height"] = self.titleLabel.heightAnchor.constraint(equalToConstant: self.fixedTitleHeight!)
        } else if ( self.headerConstraints["titleLabel-height"] != nil ) {
            self.headerConstraints["titleLabel-height"]?.isActive = false
            self.headerConstraints.removeValue(forKey: "titleLabel-height")
        }        
    }
    
    open func activateHeaderConstraints(_ key: String? = nil) {
        guard key == nil else {
            guard let constraint: NSLayoutConstraint = self.headerConstraints[key!] else { return }
            constraint.isActive = true
            return
        }
        
        self.headerConstraints.values.forEach {
            $0.isActive = true
        }
    }
    
    open func deactivateHeaderConstraints(_ key: String? = nil) {
        
        guard key == nil else {
            guard let constraint: NSLayoutConstraint = self.headerConstraints[key!] else { return }
            constraint.isActive = false
            return
        }
        
        self.headerConstraints.values.forEach {
            $0.isActive = false
        }
    }
    
}
