//
//  UIRoundLabel.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class UIRoundLabel: UILabel {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
    }
    
    override open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var s : CGSize = self.attributedText == nil ? NSAttributedString(string: "").size() : self.attributedText!.size()
        s.height = s.height + 1.0
        return CGRect(x: 0, y: 0, width: s.width + floor(s.height), height: s.height)
    }
    
    override open func draw(_ rect: CGRect) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = floor((self.frame.size.height + 1.0) / 2.0)
        super.draw(rect)
    }
    
}
