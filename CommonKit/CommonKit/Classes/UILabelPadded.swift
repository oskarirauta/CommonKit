//
//  UILabelPadded.swift
//  CommonKit
//
//  Created by Oskari Rauta on 12/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class UILabelPadded: UILabel {
    
    open var padding: UIEdgeInsets? = nil {
        didSet { self.invalidateIntrinsicContentSize() }
    }

    override open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        guard self.padding != nil else { return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines) }
        let insetRect = UIEdgeInsetsInsetRect(bounds, self.padding ?? .zero)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -(self.padding?.top ?? 0.0),
                                          left: -(self.padding?.left ?? 0.0),
                                          bottom: -(self.padding?.bottom ?? 0.0),
                                          right: -(self.padding?.right ?? 0.0))
        return UIEdgeInsetsInsetRect(textRect, invertedInsets)
    }
    
    open override func drawText(in rect: CGRect) {
        guard self.padding != nil else {
            super.drawText(in: rect)
            return
        }
        super.drawText(in: UIEdgeInsetsInsetRect(rect, self.padding ?? .zero))
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
