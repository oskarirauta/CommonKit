//
//  UIView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public func removeAllSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
    public func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }

    @discardableResult
    public final func addBorder(edges: UIRectEdge, color: UIColor = UIColor.white, thickness: CGFloat = 1.0, padding1: CGFloat? = nil, padding2: CGFloat? = nil) -> [UIView] {
        
        var borders: [UIView] = []

        func border() -> UIView {
            return UIView.create {
                $0.backgroundColor = color
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        }
                
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["top": top]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(==padding1)-[top]-(==padding2)-|",
                                               options: [],
                                               metrics: ["padding1": padding1 ?? 0.0, "padding2": -(padding2 ?? 0.0)],
                                               views: ["top": top]))
            borders.append(top)
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["left": left]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(==padding1)-[left]-(==padding2)-|",
                                               options: [],
                                               metrics: ["padding1": padding1 ?? 0.0, "padding2": -(padding2 ?? 0.0)],
                                               views: ["left": left]))
            borders.append(left)
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["right": right]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(==padding1)-[right]-(==padding2)-|",
                                               options: [],
                                               metrics: ["padding1": padding1 ?? 0.0, "padding2": -(padding2 ?? 0.0)],
                                               views: ["right": right]))
            borders.append(right)
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["bottom": bottom]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(==padding1)-[bottom]-(==padding2)-|",
                                               options: [],
                                               metrics: ["padding1": padding1 ?? 0.0, "padding2": -(padding2 ?? 0.0)],
                                               views: ["bottom": bottom]))
            borders.append(bottom)
        }
        return borders
    }

}
