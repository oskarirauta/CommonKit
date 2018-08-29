//
//  UIRoundLabel.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class UIRoundLabel: UILabelExtended {

    open var paddingAdjustment: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet { self.setNeedsContentUpdate() }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.setNeedsContentUpdate()
        self.contentUpdateIfNeeded()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.masksToBounds = true
        self.setNeedsContentUpdate()
        self.contentUpdateIfNeeded()
    }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.setNeedsContentUpdate()
        self.contentUpdateIfNeeded()
    }
    
    open override func contentUpdate() {
        super.contentUpdate()
        let s: CGSize = self.attributedText?.size() ?? CGSize(width: 0.0, height: 0.0)
        self.padding = UIEdgeInsets(top: self.paddingAdjustment.top, left: ( s.height * 0.45 ) + self.paddingAdjustment.left, bottom: self.paddingAdjustment.bottom, right: ( s.height * 0.45 ) + self.paddingAdjustment.right )
        self.layer.cornerRadius = floor((s.height + (( self.paddingAdjustment.top + self.paddingAdjustment.bottom ) * 1.5)) * 0.5 )
        self.setNeedsLayout()
    }

    
}
