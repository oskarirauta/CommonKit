//
//  PopOverExtension.swift
//  CommonKit
//
//  Created by Oskari Rauta on 19/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension PopOver {

    open var popoverLayoutMargins: UIEdgeInsets {
        get { return self.popoverPresentationController?.popoverLayoutMargins ?? .zero }
        set { self.popoverPresentationController?.popoverLayoutMargins = newValue }
    }
    
    open var backgroundColor: UIColor? {
        get { return self.popoverPresentationController?.backgroundColor ?? nil }
        set { self.popoverPresentationController?.backgroundColor = newValue }
    }
    
    open var passthroughViews: [UIView]? {
        get { return self.popoverPresentationController?.passthroughViews ?? nil }
        set { self.popoverPresentationController?.passthroughViews = newValue }
    }
    
    open var popoverBackgroundViewClass: UIPopoverBackgroundViewMethods.Type? {
        get { return self.popoverPresentationController?.popoverBackgroundViewClass }
        set { self.popoverPresentationController?.popoverBackgroundViewClass = newValue }
    }
    
    open var canOverlapSourceViewRect: Bool {
        get { return self.popoverPresentationController?.canOverlapSourceViewRect ?? false }
        set { self.popoverPresentationController?.canOverlapSourceViewRect = newValue }
    }
    
    open var barButtonItem: UIBarButtonItem? {
        get { return self.popoverPresentationController?.barButtonItem ?? nil }
        set { self.popoverPresentationController?.barButtonItem = newValue }
    }
    
    open var sourceView: UIView? {
        get { return self.popoverPresentationController?.sourceView ?? nil }
        set { self.popoverPresentationController?.sourceView = newValue }
    }
    
    open var sourceRect: CGRect {
        get { return self.popoverPresentationController?.sourceRect ?? .zero }
        set { self.popoverPresentationController?.sourceRect = newValue }
    }
    
    open var permittedArrowDirections: UIPopoverArrowDirection {
        get { return self.popoverPresentationController?.permittedArrowDirections ?? .unknown }
        set { self.popoverPresentationController?.permittedArrowDirections = newValue }
    }
    
    open var arrowDirection: UIPopoverArrowDirection {
        get { return self.popoverPresentationController?.arrowDirection ?? .unknown }
    }
        
    open func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    open func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    open func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
        self.updateContentSize()
        guard self.overlayColor != nil else { return }
        popoverPresentationController.containerView?.backgroundColor = UIColor.clear
        UIView.animate(withDuration: 0.22, animations: {
            popoverPresentationController.containerView?.backgroundColor = self.overlayColor
        })
    }

    open func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        self.dismiss_handler?()
    }

    open func setPadding(_ padding: CGFloat) {
        self.verticalPadding = padding
        self.horizontalPadding = padding
        self.updateContentSize()
    }
    
}
