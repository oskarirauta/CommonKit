//
//  FullscreenAlertControllerAnimation.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

open class FullscreenAlertControllerAnimation: AlertControllerAnimation {
    
    open override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.20
    }
    
    open override func presentAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
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
        
        UIView.animate(withDuration: 0.15, animations: {
            controller.overlayView.alpha = 1.0
            if ( controller.preferredStyle == .alert ) {
                controller.contentView.alpha = 1.0
                controller.contentView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
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
    
}
