//
//  UIMultiBadge.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class UIMultiBadge: UIView, MultiBadgeProperties, MultiBadgeMethods, MultiBadgeBase {
    
    open var badges: [BadgeCompatible]? {
        get {
            if (( self._badges?.count ?? -1 ) == 0 ) { self._badges = nil }
            return self._badges
        }
        set {
            let newBadges: [BadgeCompatible]? = newValue?.filter { $0 != nil }
            self.removeBadges()
            self._badges = ( newBadges?.count ?? -1 ) == 0 ? nil : newBadges
            self.updateBadgesFromBadgeTitles()
        }
    }
    
    open var badgeElements: [UILabelExtended]? {
        get {
            if (( self._badgeElements?.count ?? -1 ) == 0 ) { self._badgeElements = nil }
            return self._badgeElements
        }
        set {
            self.removeBadges()
            self.updateNewBadgesSet(newBadges: ( newValue?.count ?? -1) == 0 ? nil : newValue)
        }
    }
    
    open var badgeSpacing: CGFloat = 1.0 {
        didSet { self.refreshBadges() }
    }
    
    open var badgeRounding: Bool = true {
        didSet { self.refreshBadges() }
    }
    
    open var groupBadge: Bool = true {
        didSet { self.refreshBadges() }
    }
    
    open var hideOnZero: Bool = false {
        didSet { self.refreshBadges() }
    }
    
    open var badgeCornerRadius: CGFloat? = nil {
        didSet { self.refreshBadges() }
    }
    
    open var badgeFont: UIFont = UIFont.boldSystemFont(ofSize: 14.0) {
        didSet { self.refreshBadges() }
    }
        
    private var _badges: [BadgeCompatible]? = nil
    private var _badgeElements: [UILabelExtended]? = nil
    private var _badgeConstraints: [NSLayoutConstraint] = []
    private var viewConstraints: [NSLayoutConstraint]? = nil
}

extension UIMultiBadge {
    
    internal func removeBadges() {
        self._badgeConstraints.forEach { $0.isActive = false }
        self._badgeElements?.forEach { $0.removeFromSuperview() }
        self._badgeElements = nil
    }
    
    internal func updateNewBadgesSet(newBadges: Array<UILabelExtended>?) {
        
        guard ( newBadges?.count ?? 0 ) > 0 else { return }
        
        let leadingCorners: UIRectCorner = [ .topLeft, .bottomLeft ]
        let trailingCorners: UIRectCorner = [ .topRight, .bottomRight ]
        let lastIndex: Int = newBadges?.lastIndex ?? 0
        
        self._badgeElements = []
        
        newBadges?.enumerated().forEach {
            index, newBadge in
            
            newBadge.translatesAutoresizingMaskIntoConstraints = false
            newBadge.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            newBadge.layer.cornerRadius = 0.0
            newBadge.layer.masksToBounds = false

            var badgeHeight: CGFloat = newBadge.text?.toAttributed.font(self.badgeFont).getHeight(by: 500.0) ?? 0
            badgeHeight += badgeHeight > 0 ? ( 2.5 ) : 0
            let cornerRadius: CGFloat = self.badgeRounding ? CGFloat(self.badgeCornerRadius ?? ceil( badgeHeight * 0.6 )) : 0.0
            
            if (( self.badgeRounding ) && ( !self.groupBadge )) {
                newBadge.layer.masksToBounds = true
                newBadge.layer.maskedCorners = UIRectCorner.allCorners.cornerMask
                newBadge.layer.cornerRadius = cornerRadius
            } else if (( self.badgeRounding ) && ( self.groupBadge) && ( index == 0 )) {
                newBadge.layer.masksToBounds = true
                if ( index == 0 ) { newBadge.layer.maskedCorners = newBadges!.count == 1 ? UIRectCorner.allCorners.cornerMask : leadingCorners.cornerMask }
                newBadge.layer.cornerRadius = cornerRadius
            } else if (( self.badgeRounding ) && ( self.groupBadge) && ( index == lastIndex )) {
                newBadge.layer.masksToBounds = true                
                newBadge.layer.maskedCorners = trailingCorners.cornerMask
                newBadge.layer.cornerRadius = cornerRadius
            }
            
            self._badgeElements?.append(newBadge)
            self.addSubview(self.badgeElements!.last!)
        }
        
    }
    
    internal func updateBadgesFromBadgeTitles() {
        
        var filteredBadges: [BadgeItem] = self.badges?.filter {
            $0?.convertedBadge != nil && !(( self.hideOnZero ) && (( $0!.convertedBadge!.text == "0" ) || ( $0!.convertedBadge!.text.isEmpty )))
            }.map { $0!.convertedBadge! } ?? []
        
        
        defer { self.createConstraints() }
        guard filteredBadges.count != 0 else { return }
        
        var newElements: [UILabelExtended]? = []
        
        filteredBadges.enumerated().forEach {
            index, badge in
            
            newElements?.append(UILabelExtended.create {
                
                let leftPadding: CGFloat = self.badgeRounding && self.groupBadge && index == 0 ? 5.0 : ( self.badgeRounding && !self.groupBadge ? 5.0 : 2.0 )
                
                let rightPadding: CGFloat = self.badgeRounding && self.groupBadge && index == filteredBadges.lastIndex ? 5.0 : ( self.badgeRounding && !self.groupBadge ? 5.0 : 2.0 )
                
                let extraPadding: CGFloat = self.badgeFont.pointSize < 12 ? ( badge.text.count == 1 ? 3.0 : 1.0 ) : ( badge.text.count == 1 ? 5.0 : 3.0 )
                
                $0.padding = UIEdgeInsets(top: 0.5, left: leftPadding + extraPadding, bottom: 0.5, right: rightPadding + extraPadding)
                $0.text = badge.text
                $0.font = self.badgeFont
                $0.textColor = badge.foregroundColor ?? UIColor.badgeForegroundColor
                $0.backgroundColor = badge.backgroundColor ?? UIColor.badgeBackgroundColor
                $0.textAlignment = .center
            })
        }
        
        self.updateNewBadgesSet(newBadges: ( newElements?.count ?? 0 ) == 0 ? nil : newElements)
    }
    
    internal func createConstraints() {
        
        defer { self.setNeedsUpdateConstraints() }
        
        self._badgeConstraints.forEach { $0.isActive = false }
        self._badgeConstraints.removeAll()
        
        guard ( self.badgeElements?.count ?? 0 ) != 0 else { return }
        
        self.badgeElements?.enumerated().forEach {
            index, badge in
            
            self._badgeConstraints.append(from: [
                badge.topAnchor.constraint(equalTo: self.topAnchor),
                badge.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                ])
            
            self._badgeConstraints.append(index == 0 ? badge.leadingAnchor.constraint(equalTo: self.leadingAnchor) : badge.leadingAnchor.constraint(equalTo: self.badgeElements![index - 1].trailingAnchor, constant: self.badgeSpacing) )
        }
        
        self._badgeConstraints.append(self.badgeElements!.last!.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        
        self._badgeConstraints.forEach { $0.isActive = true }
        
    }
    
    open func refreshBadges() {
        self.removeBadges()
        self.updateBadgesFromBadgeTitles()
    }
    
}
