//
//  UILabelExtended.swift
//  CommonKit
//
//  Created by Oskari Rauta on 29/08/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class UILabelExtended: UIView {
    
    open lazy var label: UILabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    open var text: String? {
        get { return self.label.text }
        set {
            self.label.text = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open var attributedText: NSAttributedString? {
        get { return self.label.attributedText }
        set {
            self.label.attributedText = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open var font: UIFont! {
        get { return self.label.font }
        set {
            self.label.font = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open var textColor: UIColor! {
        get { return self.label.textColor }
        set {
            self.label.textColor = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open var textAlignment: NSTextAlignment {
        get { return self.label.textAlignment }
        set {
            self.label.textAlignment = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open var lineBreakMode: NSLineBreakMode {
        get { return self.label.lineBreakMode }
        set {
            self.label.lineBreakMode = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open var adjustsFontForContentSizeCategory: Bool {
        get { return self.label.adjustsFontForContentSizeCategory }
        set {
            self.label.adjustsFontForContentSizeCategory = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open var adjustsFontSizeToFitWidth: Bool {
        get { return self.label.adjustsFontSizeToFitWidth }
        set {
            self.label.adjustsFontSizeToFitWidth = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open var allowsDefaultTighteningForTruncation: Bool {
        get { return self.label.allowsDefaultTighteningForTruncation }
        set {
            self.label.allowsDefaultTighteningForTruncation = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open var baselineAdjustment: UIBaselineAdjustment {
        get { return self.label.baselineAdjustment }
        set {
            self.label.baselineAdjustment = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open var minimumScaleFactor: CGFloat {
        get { return self.label.minimumScaleFactor }
        set {
            self.label.minimumScaleFactor = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open var numberOfLines: Int {
        get { return self.label.numberOfLines }
        set {
            self.label.numberOfLines = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open var highlightedTextColor: UIColor? {
        get { return self.label.highlightedTextColor }
        set {
            self.label.highlightedTextColor = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open var isHighlighted: Bool {
        get { return self.label.isHighlighted }
        set {
            self.label.isHighlighted = newValue
            self.setNeedsContentUpdate()
        }
    }
        
    open var preferredMaxLayoutWidth: CGFloat {
        get { return self.label.preferredMaxLayoutWidth }
        set {
            self.label.preferredMaxLayoutWidth = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    override open var isUserInteractionEnabled: Bool { didSet { self.label.isUserInteractionEnabled = self.isUserInteractionEnabled }}
    
    open var isEnabled: Bool {
        get { return self.label.isEnabled }
        set {
            self.label.isEnabled = newValue
            self.setNeedsContentUpdate()
        }
    }
    
    open func textRect(forBounds: CGRect, limitedToNumberOfLines: Int) -> CGRect {
        return self.label.textRect(forBounds: forBounds, limitedToNumberOfLines: limitedToNumberOfLines)
    }
    
    open func sizeThatFits(size: CGSize) -> CGSize {
        return self.label.sizeThatFits(size)
    }
    
    open override func sizeToFit() {
        self.label.sizeToFit()
        self.setNeedsContentUpdate()
        super.sizeToFit()
    }
    
    open var padding: UIEdgeInsets {
        get { return UIEdgeInsets(
            top: self.labelConstraints[0].constant,
            left: self.labelConstraints[1].constant,
            bottom: -(self.labelConstraints[2].constant != 0 ? self.labelConstraints[2].constant - 1.0 : 0),
            right: -(self.labelConstraints[3].constant != 0 ? self.labelConstraints[3].constant + 0.5 : 0 )
            ) }
        set {
            self.labelConstraints[0].constant = newValue.top
            self.labelConstraints[1].constant = newValue.left
            self.labelConstraints[2].constant = -(newValue.bottom != 0 ? newValue.bottom + 1.0 : 0)
            self.labelConstraints[3].constant = -(newValue.right != 0 ? newValue.right - 0.5 : 0)
            self.setNeedsContentUpdate()
            self.setNeedsUpdateConstraints()
        }
    }
    
    lazy open var labelConstraints: [NSLayoutConstraint] = [
        self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0),
        self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0),
        self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0),
        self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0)
    ]
    
    internal var _needsContentUpdate: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizesSubviews = true
        self.addSubview(self.label)
        self.labelConstraints.forEach { $0.isActive = true }
        self.setNeedsUpdateConstraints()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.autoresizesSubviews = true
        self.addSubview(self.label)
        self.labelConstraints.forEach { $0.isActive = true }
        self.setNeedsUpdateConstraints()
    }
 
    open func setNeedsContentUpdate() {
        self._needsContentUpdate = true
    }
    
    open func needsContentUpdate() -> Bool {
        return self._needsContentUpdate
    }

    open func contentUpdate() {
        guard self._needsContentUpdate else { return }
        self._needsContentUpdate = false
    }

    open func contentUpdateIfNeeded() {
        self.contentUpdate()
    }
    
    open override func updateConstraints() {
        self.contentUpdateIfNeeded()
        super.updateConstraints()
    }
    
    open override func layoutSubviews() {
        self.contentUpdateIfNeeded()
        super.layoutSubviews()
    }
    
    open override func display(_ layer: CALayer) {
        self.contentUpdateIfNeeded()
        super.display(layer)
    }
}

