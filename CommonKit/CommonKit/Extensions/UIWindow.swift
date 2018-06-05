//
//  UIWindow.swift
//  CommonKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public enum SwapRootVCAnimationType {
    case push
    case pop
    case present
    case dismiss
}

public extension UIWindow {
    
    func swapRootViewControllerWithAnimation(newViewController: UIViewController, animationType: SwapRootVCAnimationType, completion: (() -> ())? = nil) {
        
        guard let currentViewController = rootViewController else { return }
        
        let currentX: CGFloat = currentViewController.view.frame.origin.x
        let currentY: CGFloat = currentViewController.view.frame.origin.y
        let width: CGFloat = currentViewController.view.frame.size.width
        let height: CGFloat = currentViewController.view.frame.size.height
        
        var newVCStartAnimationFrame: CGRect?
        var currentVCEndAnimationFrame: CGRect?
        
        var newVCAnimated = true
        
        switch animationType {
        case .push:
            newVCStartAnimationFrame = CGRect(x: width, y: currentY, width: width, height: height)
            currentVCEndAnimationFrame = CGRect(x: currentX - width/4, y: currentY, width: width, height: height)
        case .pop:
            currentVCEndAnimationFrame = CGRect(x: width, y: currentY, width: width, height: height)
            newVCStartAnimationFrame = CGRect(x: currentX - width/4, y: currentY, width: width, height: height)
            newVCAnimated = false
        case .present:
            newVCStartAnimationFrame = CGRect(x: currentX, y: height, width: width, height: height)
        case .dismiss:
            currentVCEndAnimationFrame = CGRect(x: currentX, y: height, width: width, height: height)
            newVCAnimated = false
        }
        
        newViewController.view.frame = newVCStartAnimationFrame ?? CGRect(x: currentX, y: currentY, width: width, height: height)
        
        addSubview(newViewController.view)
        
        if ( !newVCAnimated ) {
            bringSubview(toFront: currentViewController.view)
        }
        
        UIView.animate(withDuration: 0.35, delay: 0, options: [.curveEaseInOut], animations: {
            if let currentVCEndAnimationFrame = currentVCEndAnimationFrame {
                currentViewController.view.frame = currentVCEndAnimationFrame
            }
            
            newViewController.view.frame = CGRect(x: currentX, y: currentY, width: width, height: height)
        }, completion: { finish in
            self.rootViewController = newViewController
            completion?()
        })
        
        self.makeKeyAndVisible()
    }

}
