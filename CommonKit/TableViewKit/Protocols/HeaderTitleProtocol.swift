//
//  HeaderTitleProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 14/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol HeaderTitleProtocolBase { }

public protocol HeaderTitleProperties {
    var icon: IconCompatible { get set }
    var titleFont: UIFont! { get set }
}

public protocol HeaderTitleProtocol: HeaderTitleProtocolBase, HeaderTitleProperties, IconSettingsProtocol, TitleLabelProtocol {
    var titleLabel: UITitleLabel { get }
}

extension HeaderTitleProtocol where Self: UIHeaderFooterViewExtended {
    
    public var icon: IconCompatible {
        get { return self.titleLabel.icon }
        set { self.titleLabel.icon = newValue }
    }
    
    public var title: String? {
        get { return self.titleLabel.text }
        set { self.titleLabel.text = newValue.isEmpty ? " " : newValue?.uppercased() }
    }
    
    public var font: UIFont! {
        get { return self.titleLabel.font }
        set { self.titleLabel.font = newValue }
    }
    
    public var titleFont: UIFont! {
        get { return self.titleLabel.font }
        set { self.titleLabel.font = newValue }
    }
    
    public var hasIcon: Bool {
        get { return self.titleLabel.hasIcon }
    }
    
    public var iconFontType: FontType? {
        get { return self.titleLabel.iconFontType }
    }
    
    public var iconMargin: CGFloat {
        get { return self.titleLabel.iconMargin }
        set { self.titleLabel.iconMargin = newValue}
    }
    
    public var iconSize: CGFloat? {
        get { return self.titleLabel.iconSize }
        set { self.titleLabel.iconSize = newValue }
    }
    
    public var iconBaseLineOffset: CGFloat? {
        get { return self.titleLabel.iconBaseLineOffset }
        set { self.titleLabel.iconBaseLineOffset = newValue }
    }
    
    /* TODO: fix this?
    public var textBaselineOffset: Float? {
        get { return self.textBaselineOffset }
        set { self.textBaselineOffset = newValue }
    }
    */
}
