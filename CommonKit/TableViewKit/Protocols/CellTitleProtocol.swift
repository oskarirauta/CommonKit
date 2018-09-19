//
//  CellTitleProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol CellTitleProtocolBase { }

public protocol CellTitleProperties {
    var icon: IconCompatible { get set }
    var titleFont: UIFont! { get set }
}

public protocol CellTitleProtocol: CellTitleProtocolBase, CellTitleProperties, IconSettingsProtocol, TitleLabelProtocol {
    var titleLabel: UITitleLabel { get }
}

extension CellTitleProtocol where Self: UITableViewCellExtended {
    
    public var icon: IconCompatible {
        get { return self.titleLabel.icon }
        set { self.titleLabel.icon = newValue }
    }
    
    public var title: String? {
        get { return self.titleLabel.text }
        set { self.titleLabel.text = newValue.isEmpty ? " " : newValue }
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
/*
    public var textBaselineOffset: Float? {
        get { return self.textBaselineOffset }
        set { self.textBaselineOffset = newValue }
    }
*/
}
