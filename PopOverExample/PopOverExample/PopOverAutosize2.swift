//
//  PopOverAutosize2.swift
//  PopOverExample
//
//  Created by Oskari Rauta on 05/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CommonKit

open class PopOverAutosize2: PopOver {
    
    open lazy var label: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.boldSystemFont(ofSize: 13.5)
        $0.textColor = UIColor.black
        $0.text = "Hello World!"
    }
    
    open override func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        self.view.layoutSubviews()
        self.preferredContentSize = self.label.bounds.size.grow(width: 20.0, height: 20.0)
        super.prepareForPopoverPresentation(popoverPresentationController)
    }
    
    override open func setupView() {
        self.view.addSubview(self.label)
    }
    
    override open func setupConstraints() {
        self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
}
