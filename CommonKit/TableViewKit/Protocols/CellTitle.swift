//
//  CellTitle.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol CellTitleConfig { }

public protocol CellTitleProperties {
    
    var icon: IconCompatible { get set }
    var titleFont: UIFont! { get set }
    var titleLabel: UITitleLabel { get }
    
    var hasIcon: Bool { get }
    var iconFontType: FontType? { get }
    var iconMargin: CGFloat { get set }
    var iconSize: CGFloat? { get set }
    var iconBaseLineOffset: CGFloat? { get set }
}

public protocol CellTitleMethods { }

public protocol CellTitle: CellTitleConfig, CellTitleProperties, CellTitleMethods, IconSettingsProtocol, TitleLabelProtocol { }

public extension CellTitle where Self: UITableViewCell {
    
    var icon: IconCompatible {
        get { return self.titleLabel.icon }
        set { self.titleLabel.icon = newValue }
    }
    
    var title: String? {
        get { return self.titleLabel.text }
        set { self.titleLabel.text = newValue.isEmpty ? " " : newValue }
    }
    
    var font: UIFont! {
        get { return self.titleLabel.font }
        set { self.titleLabel.font = newValue }
    }
    
    var titleFont: UIFont! {
        get { return self.titleLabel.font }
        set { self.titleLabel.font = newValue }
    }
    
    var hasIcon: Bool {
        get { return self.titleLabel.hasIcon }
    }
    
    var iconFontType: FontType? {
        get { return self.titleLabel.iconFontType }
    }
    
    var iconMargin: CGFloat {
        get { return self.titleLabel.iconMargin }
        set { self.titleLabel.iconMargin = newValue}
    }
    
    var iconSize: CGFloat? {
        get { return self.titleLabel.iconSize }
        set { self.titleLabel.iconSize = newValue }
    }
    
    var iconBaseLineOffset: CGFloat? {
        get { return self.titleLabel.iconBaseLineOffset }
        set { self.titleLabel.iconBaseLineOffset = newValue }
    }
/*
    var textBaselineOffset: Float? {
        get { return self.textBaselineOffset }
        set { self.textBaselineOffset = newValue }
    }
*/
    
}
