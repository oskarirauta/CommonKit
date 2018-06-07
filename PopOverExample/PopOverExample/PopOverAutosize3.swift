//
//  PopOverAutosize3.swift
//  PopOverExample
//
//  Created by Oskari Rauta on 05/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CommonKit

open class PopOverAutosize3: PopOver {
    
    var contentView: UIView?

    open override func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        self.view.layoutSubviews()
        self.contentView?.layoutSubviews()
        self.contentView?.setNeedsLayout()
        self.contentView?.layoutIfNeeded()
        if ( self.contentView != nil ) {
            self.preferredContentSize = self.contentView!.bounds.size.grow(width: 20.0, height: 20.0)
        }
        super.prepareForPopoverPresentation(popoverPresentationController)
    }
    
    override open func setupView() {
        if ( self.contentView != nil ) {
            self.view.addSubview(self.contentView!)
        }
    }
    
    override open func setupConstraints() {
        self.contentView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.contentView?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
}
