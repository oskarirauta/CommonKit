//
//  PopOver.swift
//  PopOverKit
//
//  Created by Oskari Rauta on 03/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class PopOver: UIViewController, PopOverProtocol {
    
    open var contentView: UIView = UIView(frame: .zero) {
        willSet { self.removeView() }
        didSet { self.setupView() }
    }
    open var overlayColor: UIColor? = UIColor.black.withAlphaComponent(0.4)
    open var dismiss_handler: (() -> Void)? = nil
    
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
    
    open var sizeSetting: CGSize? = nil
    open var centerXConstraint: NSLayoutConstraint? = nil
    open var centerYConstraint: NSLayoutConstraint? = nil

    public init(_ contentView: UIView, from view: UIView?, arrowDirection: UIPopoverArrowDirection, size: CGSize? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.delegate = self
        self.popoverPresentationController?.permittedArrowDirections = arrowDirection
        self.popoverPresentationController?.sourceView = view
        self.popoverPresentationController?.sourceRect = view?.bounds ?? .zero
        self.sizeSetting = size
        self.contentView = contentView
        self.setupView()
    }
    
    public init(_ contentView: UIView, from button: UIBarButtonItem?, arrowDirection: UIPopoverArrowDirection, size: CGSize? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.delegate = self
        self.popoverPresentationController?.permittedArrowDirections = arrowDirection
        self.popoverPresentationController?.barButtonItem = button
        self.sizeSetting = size
        self.contentView = contentView
        self.setupView()
    }
    
    public init(_ contentView: UIView, arrowDirection: UIPopoverArrowDirection, size: CGSize? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.delegate = self
        self.popoverPresentationController?.permittedArrowDirections = arrowDirection
        self.sizeSetting = size
        self.contentView = contentView
        self.setupView()
    }
    
    public init(_ contentView: UIView, size: CGSize? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.delegate = self
        self.popoverPresentationController?.permittedArrowDirections = arrowDirection
        self.sizeSetting = size
        self.contentView = contentView
        self.setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        self.preferredContentSize = self.sizeSetting ?? self.contentView.bounds.size.grow(width: 18.0, height: 18.0)
        guard self.overlayColor != nil else { return }
        popoverPresentationController.containerView?.backgroundColor = UIColor.clear
        UIView.animate(withDuration: 0.22, animations: {
            popoverPresentationController.containerView?.backgroundColor = self.overlayColor
        })
    }
        
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard self.overlayColor != nil else { return }
        UIView.animate(withDuration: 0.20, animations: {
            self.popoverPresentationController?.containerView?.backgroundColor = UIColor.clear
        })
    }
    
    open func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        self.dismiss_handler?()
    }
    
    internal func removeView() {
        guard self.view.subviews.contains(self.contentView) else { return }
        self.centerXConstraint?.isActive = false
        self.centerYConstraint?.isActive = false
        self.contentView.removeFromSuperview()
    }
    
    public func setupView() {
        guard !self.view.subviews.contains(self.contentView) else { return }
        self.view.addSubview(self.contentView)
        self.preferredContentSize = self.sizeSetting ?? self.contentView.bounds.size.grow(width: 18.0, height: 18.0)
        self.centerXConstraint = self.contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        self.centerYConstraint = self.contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        self.centerXConstraint?.isActive = true
        self.centerYConstraint?.isActive = true
    }
    
    public func setupConstraints() { }

}
