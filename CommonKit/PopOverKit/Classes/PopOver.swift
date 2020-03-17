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

    open var horizontalPadding: CGFloat = 15.0 { didSet { self.updateContentSize() }}
    open var verticalPadding: CGFloat = 20.0 { didSet { self.updateContentSize() }}
    
    open var sizeSetting: CGSize? = nil { didSet { self.updateContentSize() }}
    
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
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard self.overlayColor != nil else { return }
        UIView.animate(withDuration: 0.20, animations: {
            self.popoverPresentationController?.containerView?.backgroundColor = .clear
        })
    }
    
    internal func updateContentSize() {
        self.preferredContentSize = self.sizeSetting ?? self.contentView.bounds.size.grow(width: self.verticalPadding, height: self.horizontalPadding)
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
        self.updateContentSize()
        let yConstant: CGFloat = self.arrowDirection == .up ? 6.0 : ( self.arrowDirection == .down ? -6.0 : 0.0)
        let xConstant: CGFloat = self.arrowDirection == .left ? 6.0 : ( self.arrowDirection == .right ? -6.0 : 0.0)
        self.centerXConstraint = self.contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: xConstant)
        self.centerYConstraint = self.contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: yConstant)
        self.centerXConstraint?.isActive = true
        self.centerYConstraint?.isActive = true
    }
}
