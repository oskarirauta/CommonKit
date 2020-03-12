//
//  UITitleLabel.swift
//  FontKit
//
//  Created by Oskari Rauta on 12/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public protocol IconSettingsProtocol {
    var iconSize: CGFloat? { get set }
    var iconColor: UIColor? { get set }
    var iconBaseLineOffset: CGFloat? { get set }
}

public protocol TitleLabelProtocol {
    var icon: IconCompatible { get set }
    var title: String? { get set }
    var titleFont: UIFont! { get set }
    var titleColor: UIColor! { get set }
    var hasIcon: Bool { get }
    var iconFontType: FontType? { get }
    var iconMargin: CGFloat { get set }
}

open class UITitleLabel: UIView, IconSettingsProtocol, TitleLabelProtocol {
    
    open class var ´default´: UITitleLabel {
        get {
            return UITitleLabel.create {
                $0.font = UIFont.boldSystemFont(ofSize: 13.5)
                $0.iconSize = 15.0
                $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        }
    }
    
    open var icon: IconCompatible = nil {
        didSet {
            
            self.iconLabel.textAlignment = self.iconOnLeft ? .left : .right
            
            let constructedIcon: AttributedStringWrapper? = self.icon?.convertedIcon?.text.toAttributed
                .font(self.icon!.convertedIcon!.font(ofSize: self.iconSize ?? self.font.pointSize)!)
                .foregroundColor(self.iconColor ?? self.textLabel.textColor ) ?? nil
                        
            if ( self.iconBaseLineOffset != nil ) {
                constructedIcon?.baselineOffset(value: self.iconBaseLineOffset ?? 0.0)
            }
            
            self.iconLabel.attributedText = constructedIcon?.rawValue ?? nil
            
            var needsConstraints: Bool = false
            
            if (( self.iconLabel.attributedText != nil ) && ( self.iconLabel.superview == nil )) {
                needsConstraints = true
                self.resetConstraints()
                self.addSubview(self.iconLabel)
            } else if (( self.iconLabel.attributedText == nil ) && ( self.iconLabel.superview != nil )) {
                needsConstraints = true
                self.resetConstraints()
                self.iconLabel.removeFromSuperview()
            } else if (( self.iconLabel.attributedText != nil ) && ( self.iconLabel.superview != nil )) {
                needsConstraints = true
                self.resetConstraints()
            }
            
            if ( needsConstraints ) {
                self.createConstraints()
                self.setNeedsUpdateConstraints()
            }
            
        }
    }
    
    open var text: String? {
        get { return self.textLabel.text }
        set { self.textLabel.text = newValue }
    }
    
    open var title: String? {
        get { return self.text }
        set { self.text = newValue }
    }
    
    open var attributedText: NSAttributedString? {
        get { return self.textLabel.attributedText }
        set { self.textLabel.attributedText = newValue }
    }
    
    open var font: UIFont! {
        get { return self.textLabel.font }
        set {
            self.textLabel.font = newValue
            if (( self.hasIcon ) && (( self.iconSize == nil ) || ( self.iconColor == nil ))) {
                self.refreshIcon()
            }
        }
    }
    
    open var titleFont: UIFont! {
        get { return self.font }
        set { self.font = newValue }
    }
    
    open var textColor: UIColor! {
        get { return self.textLabel.textColor }
        set { self.textLabel.textColor = newValue }
    }
    
    open var titleColor: UIColor! {
        get { return self.textColor }
        set { self.textColor = newValue }
    }
    
    open var textAlignment: NSTextAlignment {
        get { return self.textLabel.textAlignment }
        set { self.textLabel.textAlignment = newValue }
    }
    
    open var lineBreakMode: NSLineBreakMode {
        get { return self.textLabel.lineBreakMode }
        set { self.textLabel.lineBreakMode = newValue }
    }
    
    open var adjustsFontSizeToFitWidth: Bool {
        get { return self.textLabel.adjustsFontSizeToFitWidth }
        set { self.textLabel.adjustsFontSizeToFitWidth = newValue }
    }
    
    open var allowsDefaultTighteningForTruncation: Bool {
        get { return self.textLabel.allowsDefaultTighteningForTruncation }
        set { self.textLabel.allowsDefaultTighteningForTruncation = newValue }
    }
    
    open var baselineAdjustment: UIBaselineAdjustment {
        get { return self.textLabel.baselineAdjustment }
        set { self.textLabel.baselineAdjustment = newValue }
    }
    
    open var minimumScaleFactor: CGFloat {
        get { return self.textLabel.minimumScaleFactor }
        set { self.textLabel.minimumScaleFactor = newValue }
    }
    
    open var numberOfLines: Int {
        get { return self.textLabel.numberOfLines }
        set { self.textLabel.numberOfLines = newValue }
    }
        
    open var iconSize: CGFloat? = nil {
        didSet { self.refreshIcon() }
    }
    
    open var iconColor: UIColor? = nil {
        didSet { self.refreshIcon() }
    }
    
    open var iconBaseLineOffset: CGFloat? = nil {
        didSet { self.refreshIcon() }
    }
    
    open var iconBaseLineAdjustment: UIBaselineAdjustment {
        get { return self.iconLabel.baselineAdjustment }
        set { self.iconLabel.baselineAdjustment = newValue }
    }
    
    open var iconShadowColor: UIColor? {
        get { return self.iconLabel.shadowColor }
        set { self.iconLabel.shadowColor = newValue }
    }
    
    open var iconShadowOffset: CGSize {
        get { return self.iconLabel.shadowOffset }
        set { self.iconLabel.shadowOffset = newValue }
    }
    
    open var iconMargin: CGFloat = 2.0 {
        didSet { self.refreshConstraints() }
    }
    
    open var iconValignment: TextValignment = .top {
        didSet { self.refreshConstraints() }
    }
    
    open var iconOnLeft: Bool = true {
        didSet { self.refreshIcon() }
    }
    
    open var iconWidthSource: IconWidthSource = .font {
        didSet { self.refreshConstraints() }
    }
    
    open var padding: UIEdgeInsets? = nil {
        didSet { self.refreshConstraints() }
    }
    
    open var hasIcon: Bool {
        get { return self.icon?.convertedIcon != nil }
    }
    
    open var iconFontType: FontType? {
        get { return self.icon?.convertedIcon?.fontType }
    }
    
    public enum TextValignment: Int {
        case top
        case middle
        case bottom
    }
    
    public enum IconWidthSource {
        case font
        case icon
        case manual(CGFloat)
    }
    
    open lazy var iconLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.lineBreakMode = .byClipping
        $0.numberOfLines = 1
        $0.allowsDefaultTighteningForTruncation = false
    }
    
    open lazy var textLabel: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    internal var labelConstraints: [NSLayoutConstraint]? = nil
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.textLabel)
        self.createConstraints()
        self.setNeedsUpdateConstraints()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func refreshIcon() {
        guard self.hasIcon else { return }
        let iconBackup: IconCompatible = self.icon
        self.icon = iconBackup
    }
    
    open func refreshConstraints() {
        self.resetConstraints()
        self.createConstraints()
        self.setNeedsUpdateConstraints()
    }
    
    internal func resetConstraints() {
        self.labelConstraints?.forEach { $0.isActive = false }
        self.labelConstraints = nil
    }
    
    internal func createConstraints() {
        self.resetConstraints()
        
        if ( self.iconLabel.superview == nil ) {
            
            self.labelConstraints = [
                self.textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.padding?.top ?? 0.0),
                self.textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.padding?.left ?? 0.0),
                self.textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(self.padding?.right ?? 0.0)),
                self.textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(self.padding?.bottom ?? 0.0))
            ]
        } else {
            
            var iconWidth: CGFloat = self.iconMargin
            
            switch self.iconWidthSource {
            case .font: iconWidth += (( self.icon?.convertedIcon?.fontWidthFactor ?? 0.0 ) * ( self.iconSize ?? self.font.pointSize ))
            case .icon: iconWidth += self.iconLabel.attributedText?.size().width ?? 0.0
            case .manual(let manualWidth): iconWidth += manualWidth
            }
            
            self.labelConstraints = [
                self.textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.padding?.top ?? 0.0),
                self.textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.padding?.bottom ?? 0.0)
            ]
            
            self.labelConstraints?.append(from: self.iconOnLeft ? [
                self.iconLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.padding?.left ?? 0.0),
                self.textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: iconWidth + ( self.padding?.left ?? 0.0)),
                self.textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(self.padding?.right ?? 0.0))
                ] : [
                    self.iconLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(self.padding?.right ?? 0.0)),
                    self.textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.padding?.left ?? 0.0),
                    self.textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -( iconWidth + ( self.padding?.right ?? 0.0 ))),
                ])
            
            switch self.iconValignment {
            case .top: self.labelConstraints?.append(self.iconLabel.topAnchor.constraint(equalTo: self.textLabel.topAnchor))
            case .middle: self.labelConstraints?.append(self.iconLabel.centerYAnchor.constraint(equalTo: self.textLabel.centerYAnchor))
            case .bottom: self.labelConstraints?.append(self.iconLabel.bottomAnchor.constraint(equalTo: self.textLabel.bottomAnchor))
            }
            
            if (( self.iconValignment.isAny(of: .top, .middle)) && (( self.iconBaseLineOffset ?? 0.0 ) < 0 )) {
                self.labelConstraints?.append(self.iconLabel.heightAnchor.constraint(equalToConstant: self.iconLabel.attributedText!.size().height + ( 2 * ( -self.iconBaseLineOffset! ))))
            }
            
            if (( self.iconValignment.isAny(of: .bottom, .middle)) && (( self.iconBaseLineOffset ?? 0.0 ) > 0 )) {
                self.labelConstraints?.append(self.iconLabel.heightAnchor.constraint(equalToConstant: self.iconLabel.attributedText!.size().height + ( 2 * self.iconBaseLineOffset! )))
            }
            
        }
        
        self.labelConstraints?.forEach { $0.isActive = true }
    }
    
}
