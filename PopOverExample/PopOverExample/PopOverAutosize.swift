//
//  PopOverAutosize.swift
//  PopOverExample
//
//  Created by Oskari Rauta on 05/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CommonKit

open class PopOverAutosize: PopOver {
    
    open lazy var contentView: UIView = UIView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    open lazy var label: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.boldSystemFont(ofSize: 13.5)
        $0.textColor = UIColor.black
        $0.text = "Hello World!"
    }
    
    open override func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
        self.preferredContentSize = self.contentView.bounds.size
        super.prepareForPopoverPresentation(popoverPresentationController)
    }
    
    override open func setupView() {
        self.view.addSubview(self.contentView)
        self.contentView.addSubview(self.label)
    }
    
    override open func setupConstraints() {
        self.label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        self.label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.contentView.widthAnchor.constraint(equalTo: self.label.widthAnchor, constant: 22.0).isActive = true
        self.contentView.heightAnchor.constraint(equalTo: self.label.heightAnchor, constant: 22.0).isActive = true
    }
    
}
