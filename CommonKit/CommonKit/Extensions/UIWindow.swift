//
//  UIWindow.swift
//  CommonKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

// Partly from  https://medium.com/@danielemargutti/animate-uiwindows-rootviewcontroller-transitions-2887ccf3fecc

import Foundation
import UIKit

public extension UIWindow {
    
    struct UIViewAnimationOptions {
        
        public enum AnimationType {
            case crossDissolve
            case curlUp
            case curlDown
            case flipFromTop
            case flipFromBottom
            case flipFromLeft
            case flipFromRight
        }

        /// Type of the transition (default is `crossDissolve`)
        public var type: UIViewAnimationOptions.AnimationType = .crossDissolve
        
        /// Duration of the animation (default is 0.35s)
        public var duration: TimeInterval = 0.35

        /// Initialize a new options object with given type and duration
        ///
        /// - Parameters:
        ///   - direction: direction
        ///   - style: style
        public init(type: UIViewAnimationOptions.AnimationType = .crossDissolve, duration: TimeInterval = 0.35) {
            self.type = type
            self.duration = duration
        }
            
        public init() { }
            
        /// Return the animation options to perform for given options object
        internal var animation: UIView.AnimationOptions {
            switch self.type {
            case .crossDissolve: return .transitionCrossDissolve
            case .curlUp: return .transitionCurlUp
            case .curlDown: return .transitionCurlDown
            case .flipFromTop: return .transitionFlipFromTop
            case .flipFromBottom: return .transitionFlipFromBottom
            case .flipFromLeft: return .transitionFlipFromLeft
            case .flipFromRight: return .transitionFlipFromRight
            }
        }
        
    }
    
    /// Transition Options
    struct TransitionOptions {
        
        /// Curve of animation
        ///
        /// - linear: linear
        /// - easeIn: ease in
        /// - easeOut: ease out
        /// - easeInOut: ease in - ease out
        public enum Curve {
            case linear
            case easeIn
            case easeOut
            case easeInOut
            
            /// Return the media timing function associated with curve
            internal var function: CAMediaTimingFunction {
                switch self {
                case .linear: return CAMediaTimingFunction(name: .linear)
                case .easeIn: return CAMediaTimingFunction(name: .easeIn)
                case .easeOut: return CAMediaTimingFunction(name: .easeOut)
                case .easeInOut: return CAMediaTimingFunction(name: .easeInEaseOut)
                }
            }
        }

        /// Direction of the animation
        ///
        /// - fade: fade to new controller
        /// - toTop: slide from bottom to top
        /// - toBottom: slide from top to bottom
        /// - toLeft: pop to left
        /// - toRight: push to right
        public enum Direction {
            case fade
            case toTop
            case toBottom
            case toLeft
            case toRight
            case pop
            case push
        }

        /// Background of the transition
        ///
        /// - solidColor: solid color
        /// - customView: custom view
        public enum Background {
            case solidColor(_: UIColor)
            case customView(_: UIView)
        }

        /// Duration of the animation (default is 0.35s)
        public var duration: TimeInterval = 0.35
            
        /// Direction of the transition (default is `push`)
        public var direction: TransitionOptions.Direction = .push
            
        /// Style of the transition (default is `easyInOut`)
        public var style: TransitionOptions.Curve = .easeInOut
            
        /// Background of the transition (default is `nil`)
        public var background: TransitionOptions.Background? = nil
            
        /// Initialize a new options object with given direction, curve, duration and background
        ///
        /// - Parameters:
        ///   - direction: direction
        ///   - style: style
        ///   - duration: duration
        ///   - background: background
        public init(direction: TransitionOptions.Direction = .toRight, style: TransitionOptions.Curve = .easeInOut, duration: TimeInterval = 0.35, background: TransitionOptions.Background? = nil) {
            self.direction = direction
            self.style = style
            self.duration = duration
            self.background = background
        }
            
        public init() { }

        /// Return the associated transition
        ///
        /// - Returns: transition
        internal var transition: CATransition {
            let transition = CATransition()
            transition.type = .push
            switch self.direction {
            case .fade:
                transition.type = .fade
                transition.subtype = nil
            case .toLeft:
                transition.subtype = .fromLeft
            case .pop:
                transition.subtype = .fromLeft
            case .toRight:
                transition.subtype = .fromRight
            case .push:
                transition.subtype = .fromRight
            case .toTop:
                transition.subtype = .fromTop
            case .toBottom:
                transition.subtype = .fromBottom
            }
            return transition
        }
            
        /// Return the animation to perform for given options object
        internal var animation: CATransition {
            let transition = self.transition
            transition.duration = self.duration
            transition.timingFunction = self.style.function
            return transition
        }
    }

    func swapRootViewController(withAnimation: UIWindow.UIViewAnimationOptions = UIWindow.UIViewAnimationOptions(), viewController: UIViewController, completion: (() -> ())? = nil) {
        
        let window = UIApplication.shared.windows.first!
        window.rootViewController = viewController
                
        UIView.transition(with: window, duration: withAnimation.duration, options: withAnimation.animation, animations: nil, completion: {
            completed in
            self.rootViewController = viewController
        })
                
        self.makeKeyAndVisible()
    }

    func swapRootViewController(withAnimation: UIWindow.TransitionOptions = UIWindow.TransitionOptions(), viewController: UIViewController, completion: (() -> ())? = nil) {
        
        var transitionWnd: UIWindow? = nil
        if let background = withAnimation.background {
            transitionWnd = UIWindow(frame: UIScreen.main.bounds)
            switch background {
            case .customView(let view):
                transitionWnd?.rootViewController = UIViewController.newController(withView: view, frame: transitionWnd!.bounds)
            case .solidColor(let color):
                transitionWnd?.backgroundColor = color
            }
            transitionWnd?.makeKeyAndVisible()
        }
        
        // Make animation
        self.layer.add(withAnimation.animation, forKey: "transition")
        self.rootViewController = viewController
        self.makeKeyAndVisible()
        
        if let wnd = transitionWnd {
            DispatchQueue.main.asyncAfter(deadline: (.now() + 1 + withAnimation.duration), execute: {
                wnd.removeFromSuperview()
                completion?()
            })
        }
        
    }

}

internal extension UIViewController {
    
    /// Create a new empty controller instance with given view
    ///
    /// - Parameters:
    ///   - view: view
    ///   - frame: frame
    /// - Returns: instance
    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
        view.frame = frame
        let controller = UIViewController()
        controller.view = view
        return controller
    }
    
}
