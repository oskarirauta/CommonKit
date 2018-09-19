//
//  AlertControllerAnimation.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class AlertControllerAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    public let isPresenting: Bool
    
    public init(isPresenting: Bool) {
        
        self.isPresenting = isPresenting
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return self.isPresenting ? 0.45 : 0.25
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if (isPresenting) { self.presentAnimateTransition(transitionContext) }
        else { self.dismissAnimateTransition(transitionContext) }
    }
    
    open func presentAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        let controller = transitionContext.viewController(forKey: .to) as! AlertControllerViewProtocol
        let containerView = transitionContext.containerView
        
        controller.overlayView.alpha = 0.0
        if ( controller.preferredStyle == .alert ) {
            controller.contentView.alpha = 0.0
            controller.contentView.center = controller.view.center
            controller.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        } else {
            controller.contentView.transform = CGAffineTransform(translationX: 0, y: controller.contentView.frame.height)
        }
        
        containerView.addSubview(controller.view)
        
        UIView.animate(withDuration: 0.25, animations: {
            controller.overlayView.alpha = 1.0
            if ( controller.preferredStyle == .alert ) {
                controller.contentView.alpha = 1.0
                controller.contentView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            } else {
                controller.contentView.transform = CGAffineTransform(translationX: 0, y: -(controller.contentView.frame.height / 480 * 10.0 + 10.0))
            }
        }, completion: {
            finished in
            
            UIView.animate(
                withDuration: 0.2,
                animations: { controller.contentView.transform = CGAffineTransform.identity },
                completion: {
                    finished in if ( finished ) { transitionContext.completeTransition(true) }
            })
        })
        
    }
    
    open func dismissAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        let controller = transitionContext.viewController(forKey: .from) as! AlertControllerViewProtocol
        
        UIView.animate(
            withDuration: self.transitionDuration(using: transitionContext),
            animations: {
                controller.overlayView.alpha = 0.0
                if ( controller.preferredStyle == .alert ) {
                    controller.contentView.alpha = 0.0
                    controller.contentView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                } else {
                    controller.containerView.transform = CGAffineTransform(translationX: 0, y: controller.contentView.frame.height)
                }},
            completion: { finished in transitionContext.completeTransition(true) })
    }
}
