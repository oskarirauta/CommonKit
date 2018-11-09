//
//  DefaultAlertControllerBaseClass.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

@objc(DefaultAlertControllerBaseClass)
open class DefaultAlertControllerBaseClass: UIViewController, AlertControllerViewProtocol, AlertActionProtocol, UIViewControllerTransitioningDelegate {
            
    open var fullscreen: Bool { get { return DefaultAlertProperties.fullScreen }}
    
    open internal(set) var _preferredStyle: AlertControllerStyle = .alert
    open var preferredStyle: AlertControllerStyle { get { return self._preferredStyle }}
    
    // Settings

    open var buttonFont: [AlertActionStyle: UIFont] = [:]
    open var buttonTextColor: [AlertActionStyle: UIColor] = [:]
    open var buttonBgColor: [AlertActionStyle: UIColor] = [:]
    open var buttonBgColorHighlighted: [AlertActionStyle: UIColor] = [:]
    
    open var actionSheetBounceHeight: CGFloat? = nil
    open var alertViewWidth: CGFloat? = nil
    open var alertViewPadding: CGFloat? = nil
    open var innerContentWidth: CGFloat? = nil
    
    open var overlayColor: UIColor? = nil
    open var contentViewBgColor: UIColor? = nil
    
    open var contentViewDefaultHeight: CGFloat? = nil {
        didSet {
            self.contentViewHeightConstraint?.constant = self.contentViewDefaultHeight ?? DefaultAlertProperties.contentViewDefaultHeight
        }
    }
    
    open var buttonCornerRadius: CGFloat? = nil
    open var buttonShadowColor: UIColor? = nil
    open var buttonHeight: CGFloat? = nil
    open var buttonMargin: CGFloat? = nil
    
    open lazy var overlayView: UIView = UIView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = self.overlayColor ?? DefaultAlertProperties.overlayColor
    }
    
    open lazy var containerView: UIView = UIView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addSubview(self.contentView)
    }
    
    open var containerViewBottomConstraint: NSLayoutConstraint? = nil
    
    open lazy var contentView: UIView = UIView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = self.contentViewBgColor ?? DefaultAlertProperties.contentViewBgColor
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = self.preferredStyle == .alert ? 8.0 : 0.0
    }
    
    open var contentViewHeightConstraint: NSLayoutConstraint? = nil
    
    open var layoutFlg: Bool = false
    
    open var currentOrientation: UIInterfaceOrientation {
        get {
            return UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height ? .portrait : .landscapeLeft
        }
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setupNotifications()
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overFullScreen
        self.transitioningDelegate = self
        self.viewRespectsSystemMinimumLayoutMargins = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Initializer
    public init(title: String?, preferredStyle: AlertControllerStyle) {
        super.init(nibName: nil, bundle: nil)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overFullScreen
        self.setupNotifications()
        self.title = title
        self._preferredStyle = preferredStyle
        self.setupView()
        self.setupConstraints()
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overFullScreen
        self.setupNotifications()
        self.title = nil
        self._preferredStyle = .alert
        self.setupView()
        self.setupConstraints()
    }
    
    public init(stockInit: Bool, preferredStyle: AlertControllerStyle = .alert) {
        super.init(nibName: nil, bundle: nil)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overFullScreen
        self.setupNotifications()
        self.title = nil
        self._preferredStyle = preferredStyle
        
        if !stockInit {
            self.setupView()
            self.setupConstraints()
        }
    }

    open func setupNotifications() { }
    
    open func setupView() {
        
        self.view.addSubview(self.overlayView)
        self.view.addSubview(self.containerView)
    }
    
    open func setupConstraints() {
        
        // OverlayView
        
        self.overlayView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -40.0).isActive = true
        self.overlayView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.overlayView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.overlayView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // ContainerView
        
        self.containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.containerViewBottomConstraint = self.containerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -(UIApplication.shared.statusBarFrame.size.height - 20.0))
        self.containerViewBottomConstraint?.isActive = true
        
        // ContentView
        
        self.contentView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
        
        if ( self.preferredStyle == .alert ) {
            
            if ( self.fullscreen ) {
                
                self.contentView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 8.0).isActive = true
                self.contentView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 8.0).isActive = true
                self.contentView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -8.0).isActive = true
                self.contentView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -28.0).isActive = true
                
            } else {
                
                self.contentView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor).isActive = true
                self.contentView.widthAnchor.constraint(equalToConstant: self.alertViewWidth ?? DefaultAlertProperties.alertViewWidth).isActive = true
                self.contentViewHeightConstraint = self.contentView.heightAnchor.constraint(equalToConstant: self.contentViewDefaultHeight ?? DefaultAlertProperties.contentViewDefaultHeight)
                self.contentViewHeightConstraint?.isActive = true
                
            }
            
        } else {
            
            if ( self.fullscreen ) {
                
                self.contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8.0).isActive = true
                self.contentView.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, constant: 0.0).isActive = true
                self.contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: self.actionSheetBounceHeight ?? DefaultAlertProperties.actionSheetBounceHeight).isActive = true
                
            } else {
                
                self.contentView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
                self.contentView.bottomAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.bottomAnchor, constant: self.actionSheetBounceHeight ?? DefaultAlertProperties.actionSheetBounceHeight).isActive = true
                self.contentView.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, constant: 0.0).isActive = true
                self.contentViewHeightConstraint = self.contentView.heightAnchor.constraint(equalToConstant: self.contentViewDefaultHeight ?? DefaultAlertProperties.contentViewDefaultHeight)
                self.contentViewHeightConstraint?.isActive = true
                
            }
        }
    }
    
    open func layoutView(_ presenting: UIViewController? = nil) { }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.layoutView(self.presentingViewController)
    }
    
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.layoutView(presenting)
        return self.fullscreen ? FullscreenAlertControllerAnimation(isPresenting: true) :  AlertControllerAnimation(isPresenting: true)
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.fullscreen ? FullscreenAlertControllerAnimation(isPresenting: false) : AlertControllerAnimation(isPresenting: false)
    }
    
}
