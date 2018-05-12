//
//  UILabelPadded.swift
//  CommonKit
//
//  Created by Oskari Rauta on 12/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

@IBDesignable open class UILabelPadded: UILabel {
    
    open var padding: UIEdgeInsets? = nil {
        didSet { self.setNeedsDisplay() }
    }

    open override func drawText(in rect: CGRect) {
        super.drawText(in: self.padding == nil ? rect : UIEdgeInsetsInsetRect(rect, padding!))
    }
    
    override open var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            if let insets = padding {
                contentSize.height += insets.top + insets.bottom
                contentSize.width += insets.left + insets.right
            }
            return contentSize
        }
    }
}
