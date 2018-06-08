//
//  UIBlockLabel.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class UIBlockLabel: UILabel {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
    }
    
    override open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let s : CGSize = self.attributedText!.size()
        return CGRect(x: 0, y: 0, width: s.width + floor(s.height / 2), height: s.height)
    }
    
    override open func draw(_ rect: CGRect) {
        self.layer.masksToBounds = true
        super.draw(rect)
    }
    
}
