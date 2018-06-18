//
//  PopOverCustomContent.swift
//  PopOverExample
//
//  Created by Oskari Rauta on 05/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CommonKit

open class PopOverCustomContent: UIView {
    
    open var label: HelloLabel = HelloLabel()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.label)
        self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: self.label.widthAnchor, constant: 24.0).isActive = true
        self.heightAnchor.constraint(equalTo: self.label.heightAnchor, constant: 24.0).isActive = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
