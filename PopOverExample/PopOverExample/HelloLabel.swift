//
//  HelloLabel.swift
//  PopOverExample
//
//  Created by Oskari Rauta on 05/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CommonKit

open class HelloLabel: UILabel {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.boldSystemFont(ofSize: 13.5)
        self.textColor = UIColor.black
        self.text = "Hello World!"
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
