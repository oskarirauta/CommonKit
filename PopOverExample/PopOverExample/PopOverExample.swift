//
//  PopOverExample.swift
//  PopOverExample
//
//  Created by Oskari Rauta on 03/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CommonKit

open class PopOverExample: PopOver {
    
    open lazy var label: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.boldSystemFont(ofSize: 13.5)
        $0.textColor = UIColor.black
        $0.text = "Hello World!"
    }
            
    override open func setupView() {
        self.view.addSubview(self.label)
    }
    
    override open func setupConstraints() {
        self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
}
