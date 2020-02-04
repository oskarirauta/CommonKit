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
    case crossDissolve
    case curlUp
    case curlDown
    case flipFromTop
    case flipFromBottom
    case flipFromLeft
    case flipFromRight
}

public extension UIWindow {
    
    func swapRootViewControllerWithAnimation(newViewController: UIViewController, animationType: SwapRootVCAnimationType, withDuration: TimeInterval = TimeInterval(0.35), completion: (() -> ())? = nil) {
        
        guard let currentViewController = rootViewController else { return }
        
        let currentX: CGFloat = currentViewController.view.frame.origin.x
        let currentY: CGFloat = currentViewController.view.frame.origin.y
        let width: CGFloat = currentViewController.view.frame.size.width
        let height: CGFloat = currentViewController.view.frame.size.height
        
        var newVCStartAnimationFrame: CGRect?
        var currentVCEndAnimationFrame: CGRect?
        
        var newVCAnimated: Bool = true
        var basicAnimation: Bool = false
        var options: UIView.AnimationOptions = .transitionCrossDissolve
        
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
        case .crossDissolve:
            newVCAnimated = false
            basicAnimation = false
            options = .transitionCrossDissolve
        case .curlUp:
            newVCAnimated = false
            basicAnimation = false
            options = .transitionCurlUp
        case .curlDown:
            newVCAnimated = false
            basicAnimation = false
            options = .transitionCurlDown
        case .flipFromTop:
            newVCAnimated = false
            basicAnimation = false
            options = .transitionFlipFromTop
        case .flipFromBottom:
            newVCAnimated = false
            basicAnimation = false
            options = .transitionFlipFromBottom
        case .flipFromLeft:
            newVCAnimated = false
            basicAnimation = false
            options = .transitionFlipFromLeft
        case .flipFromRight:
            newVCAnimated = false
            basicAnimation = false
            options = .transitionFlipFromRight
        }

        if basicAnimation {
            newViewController.view.frame = newVCStartAnimationFrame ?? CGRect(x: currentX, y: currentY, width: width, height: height)
        
            addSubview(newViewController.view)
        
            if ( !newVCAnimated ) {
                bringSubviewToFront(currentViewController.view)
            }
            
            UIView.animate(withDuration: withDuration, delay: 0, options: [.curveEaseInOut], animations: {
                if let currentVCEndAnimationFrame = currentVCEndAnimationFrame {
                    currentViewController.view.frame = currentVCEndAnimationFrame
                }
                
                newViewController.view.frame = CGRect(x: currentX, y: currentY, width: width, height: height)
            }, completion: { finish in
                self.rootViewController = newViewController
                completion?()
            })

        } else {
            
            let window = UIApplication.shared.windows.first!
            window.rootViewController = newViewController
                
            UIView.transition(with: window, duration: withDuration, options: options, animations: nil, completion: {
                completed in
                self.rootViewController = newViewController
            })
        }
                
        self.makeKeyAndVisible()
    }

}
