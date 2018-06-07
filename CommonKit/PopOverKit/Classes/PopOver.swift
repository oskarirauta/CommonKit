//
//  PopOver.swift
//  PopOverKit
//
//  Created by Oskari Rauta on 03/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class PopOver: UIViewController, PopOverProtocol {
    
    open var overlayColor: UIColor? = UIColor.black.withAlphaComponent(0.4)
    open var dismiss_handler: (() -> Void)? = nil
    
    open func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    open func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    open func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
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
    
    open func setupView() { }
    
    open func setupConstraints() { }
    
}
