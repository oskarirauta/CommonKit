//
//  UIViewController.swift
//  PopOverKit
//
//  Created by Oskari Rauta on 03/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension UIPopoverPresentationControllerDelegate where Self: UIViewController {
    
    public var popoverLayoutMargins: UIEdgeInsets {
        get { return self.popoverPresentationController?.popoverLayoutMargins ?? .zero }
        set { self.popoverPresentationController?.popoverLayoutMargins = newValue }
    }
    
    public var backgroundColor: UIColor? {
        get { return self.popoverPresentationController?.backgroundColor ?? nil }
        set { self.popoverPresentationController?.backgroundColor = newValue }
    }
    
    public var passthroughViews: [UIView]? {
        get { return self.popoverPresentationController?.passthroughViews ?? nil }
        set { self.popoverPresentationController?.passthroughViews = newValue }
    }
    
    public var popoverBackgroundViewClass: UIPopoverBackgroundViewMethods.Type? {
        get { return self.popoverPresentationController?.popoverBackgroundViewClass }
        set { self.popoverPresentationController?.popoverBackgroundViewClass = newValue }
    }
    
    public var canOverlapSourceViewRect: Bool {
        get { return self.popoverPresentationController?.canOverlapSourceViewRect ?? false }
        set { self.popoverPresentationController?.canOverlapSourceViewRect = newValue }
    }
    
    public var barButtonItem: UIBarButtonItem? {
        get { return self.popoverPresentationController?.barButtonItem ?? nil }
        set { self.popoverPresentationController?.barButtonItem = newValue }
    }
    
    public var sourceView: UIView? {
        get { return self.popoverPresentationController?.sourceView ?? nil }
        set { self.popoverPresentationController?.sourceView = newValue }
    }
    
    public var sourceRect: CGRect {
        get { return self.popoverPresentationController?.sourceRect ?? .zero }
        set { self.popoverPresentationController?.sourceRect = newValue }
    }
    
    public var permittedArrowDirections: UIPopoverArrowDirection {
        get { return self.popoverPresentationController?.permittedArrowDirections ?? .unknown }
        set { self.popoverPresentationController?.permittedArrowDirections = newValue }
    }
    
    public var arrowDirection: UIPopoverArrowDirection {
        get { return self.popoverPresentationController?.arrowDirection ?? .unknown }
    }
    
    public init(from view: UIView?, size: CGSize, arrowDirection: UIPopoverArrowDirection) {
        self.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.delegate = self
        self.popoverPresentationController?.permittedArrowDirections = arrowDirection
        self.popoverPresentationController?.sourceView = view
        self.popoverPresentationController?.sourceRect = view?.bounds ?? .zero
        self.preferredContentSize = size
        (self as! PopOverProtocol).setupView()
        (self as! PopOverProtocol).setupConstraints()
    }
    
    public init(from button: UIBarButtonItem?, size: CGSize, arrowDirection: UIPopoverArrowDirection) {
        self.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.delegate = self
        self.popoverPresentationController?.permittedArrowDirections = arrowDirection
        self.popoverPresentationController?.barButtonItem = button
        self.preferredContentSize = size
        (self as! PopOverProtocol).setupView()
        (self as! PopOverProtocol).setupConstraints()
    }
    
    public init(size: CGSize, arrowDirection: UIPopoverArrowDirection) {
        self.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.delegate = self
        self.popoverPresentationController?.permittedArrowDirections = arrowDirection
        self.preferredContentSize = size
        (self as! PopOverProtocol).setupView()
        (self as! PopOverProtocol).setupConstraints()
    }
    
    public init(size: CGSize) {
        self.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.delegate = self
        self.popoverPresentationController?.permittedArrowDirections = arrowDirection
        self.preferredContentSize = size
        (self as! PopOverProtocol).setupView()
        (self as! PopOverProtocol).setupConstraints()
    }
    
}
