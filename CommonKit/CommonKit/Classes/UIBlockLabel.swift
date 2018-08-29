//
//  UIBlockLabel.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class UIBlockLabel: UILabelExtended {

    open var paddingAdjustment: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet { self.setNeedsContentUpdate() }
    }

    open override func contentUpdate() {
        super.contentUpdate()
        let s: CGSize = self.attributedText?.size() ?? CGSize(width: 0.0, height: 0.0)
        self.padding = UIEdgeInsets(top: self.paddingAdjustment.top, left: ( s.height * 0.25 ) + self.paddingAdjustment.left, bottom: self.paddingAdjustment.bottom, right: ( s.height * 0.25 ) + self.paddingAdjustment.right )
    }
    
}
