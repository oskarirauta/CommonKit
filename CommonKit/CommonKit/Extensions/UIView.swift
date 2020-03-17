//
//  UIView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {

    /// SwifterSwift: Shake directions of a view.
    ///
    /// - horizontal: Shake left and right.
    /// - vertical: Shake up and down.
    enum ShakeDirection {
        /// SwifterSwift: Shake left and right.
        case horizontal

        /// SwifterSwift: Shake up and down.
        case vertical
    }

    /// SwifterSwift: Angle units.
    ///
    /// - degrees: degrees.
    /// - radians: radians.
    enum AngleUnit {
        /// SwifterSwift: degrees.
        case degrees

        /// SwifterSwift: radians.
        case radians
    }

    /// SwifterSwift: Shake animations types.
    ///
    /// - linear: linear animation.
    /// - easeIn: easeIn animation.
    /// - easeOut: easeOut animation.
    /// - easeInOut: easeInOut animation.
    enum ShakeAnimationType {
        /// SwifterSwift: linear animation.
        case linear

        /// SwifterSwift: easeIn animation.
        case easeIn

        /// SwifterSwift: easeOut animation.
        case easeOut

        /// SwifterSwift: easeInOut animation.
        case easeInOut
    }

}

// MARK: - Properties
public extension UIView {

    /// SwifterSwift: Border color of view; also inspectable from Storyboard.
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }

    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    /// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

    /// SwifterSwift: Height of view.
    var frameHeight: CGFloat {
        get { return frame.size.height }
        set { frame.size.height = newValue }
    }
    

    /// SwifterSwift: Check if view is in RTL format.
    var isRightToLeft: Bool {
        return effectiveUserInterfaceLayoutDirection == .rightToLeft
    }

    /// SwifterSwift: Take screenshot of view (if applicable).
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /// SwifterSwift: Shadow color of view; also inspectable from Storyboard.
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set { layer.shadowColor = newValue?.cgColor }
    }

    /// SwifterSwift: Shadow offset of view; also inspectable from Storyboard.
    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

    /// SwifterSwift: Shadow opacity of view; also inspectable from Storyboard.
    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }

    /// SwifterSwift: Shadow radius of view; also inspectable from Storyboard.
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }

    /// SwifterSwift: Size of view.
    var size: CGSize {
        get { return frame.size }
        set {
            self.frameWidth = newValue.width
            self.frameHeight = newValue.height
        }
    }

    /// SwifterSwift: Get view's parent view controller
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    
    /// SwifterSwift: Width of view.
    var frameWidth: CGFloat {
        get { return frame.size.width }
        set { frame.size.width = newValue }
    }

    // swiftlint:disable identifier_name
    /// SwifterSwift: x origin of view.
    var x: CGFloat {
        get { return frame.origin.x }
        set { frame.origin.x = newValue }
    }
    // swiftlint:enable identifier_name
    // swiftlint:disable identifier_name
    /// SwifterSwift: y origin of view.
    var y: CGFloat {
        get { return frame.origin.y }
        set { frame.origin.y = newValue }
    }
    // swiftlint:enable identifier_name
}



public extension UIView {
    
    func removeAllSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
    @discardableResult
    final func addBorder(edges: UIRectEdge, color: UIColor = UIColor.white, thickness: CGFloat = 1.0, padding1: CGFloat? = nil, padding2: CGFloat? = nil) -> [UIView] {
        
        var borders: [UIView] = []

        func border() -> UIView {
            return UIView.create {
                $0.backgroundColor = color
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        }
                
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["top": top]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(==padding1)-[top]-(==padding2)-|",
                                               options: [],
                                               metrics: ["padding1": padding1 ?? 0.0, "padding2": -(padding2 ?? 0.0)],
                                               views: ["top": top]))
            borders.append(top)
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["left": left]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(==padding1)-[left]-(==padding2)-|",
                                               options: [],
                                               metrics: ["padding1": padding1 ?? 0.0, "padding2": -(padding2 ?? 0.0)],
                                               views: ["left": left]))
            borders.append(left)
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["right": right]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(==padding1)-[right]-(==padding2)-|",
                                               options: [],
                                               metrics: ["padding1": padding1 ?? 0.0, "padding2": -(padding2 ?? 0.0)],
                                               views: ["right": right]))
            borders.append(right)
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["bottom": bottom]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(==padding1)-[bottom]-(==padding2)-|",
                                               options: [],
                                               metrics: ["padding1": padding1 ?? 0.0, "padding2": -(padding2 ?? 0.0)],
                                               views: ["bottom": bottom]))
            borders.append(bottom)
        }
        return borders
    }

    /// SwifterSwift: Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }

    /// SwifterSwift: Add shadow to view.
    ///
    /// - Parameters:
    ///   - color: shadow color (default is #137992).
    ///   - radius: shadow radius (default is 3).
    ///   - offset: shadow offset (default is .zero).
    ///   - opacity: shadow opacity (default is 0.5).
    func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }

    /// SwifterSwift: Add array of subviews to view.
    ///
    /// - Parameter subviews: array of subviews to add to self.
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }

    /// SwifterSwift: Fade in view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    func fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: completion)
    }

    /// SwifterSwift: Fade out view.
    ///
    /// - Parameters:
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil)
    func fadeOut(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: completion)
    }
    
 /// SwifterSwift: Rotate view by angle on relative axis.
    ///
    /// - Parameters:
    ///   - angle: angle to rotate view by.
    ///   - type: type of the rotation angle.
    ///   - animated: set true to animate rotation (default is true).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func rotate(byAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.transform = self.transform.rotated(by: angleWithType)
        }, completion: completion)
    }

    /// SwifterSwift: Rotate view to angle on fixed axis.
    ///
    /// - Parameters:
    ///   - angle: angle to rotate view to.
    ///   - type: type of the rotation angle.
    ///   - animated: set true to animate rotation (default is false).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func rotate(toAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        let angleWithType = (type == .degrees) ? .pi * angle / 180.0 : angle
        let aDuration = animated ? duration : 0
        UIView.animate(withDuration: aDuration, animations: {
            self.transform = self.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
        }, completion: completion)
    }

    /// SwifterSwift: Scale view by offset.
    ///
    /// - Parameters:
    ///   - offset: scale offset
    ///   - animated: set true to animate scaling (default is false).
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
                self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
            }, completion: completion)
        } else {
            transform = transform.scaledBy(x: offset.x, y: offset.y)
            completion?(true)
        }
    }

    /// SwifterSwift: Shake view.
    ///
    /// - Parameters:
    ///   - direction: shake direction (horizontal or vertical), (default is .horizontal)
    ///   - duration: animation duration in seconds (default is 1 second).
    ///   - animationType: shake animation type (default is .easeOut).
    ///   - completion: optional completion handler to run with animation finishes (default is nil).
    func shake(direction: ShakeDirection = .horizontal, duration: TimeInterval = 1, animationType: ShakeAnimationType = .easeOut, completion:(() -> Void)? = nil) {
        CATransaction.begin()
        let animation: CAKeyframeAnimation
        switch direction {
        case .horizontal:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        case .vertical:
            animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        }
        switch animationType {
        case .linear:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        case .easeIn:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        case .easeOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        case .easeInOut:
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        }
        CATransaction.setCompletionBlock(completion)
        animation.duration = duration
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
        CATransaction.commit()
    }

    /// SwifterSwift: Add Visual Format constraints.
    ///
    /// - Parameters:
    ///   - withFormat: visual Format language
    ///   - views: array of views which will be accessed starting with index 0 (example: [v0], [v1], [v2]..)
    func addConstraints(withFormat: String, views: UIView...) {
        // https://videos.letsbuildthatapp.com/
        var viewsDictionary: [String: UIView] = [:]
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: withFormat, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }

    /// SwifterSwift: Anchor all sides of the view into it's superview.
    func fillToSuperview() {
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }

    /// SwifterSwift: Add anchors from any side of the current view into the specified anchors and returns the newly added constraints.
    ///
    /// - Parameters:
    ///   - top: current view's top anchor will be anchored into the specified anchor
    ///   - left: current view's left anchor will be anchored into the specified anchor
    ///   - bottom: current view's bottom anchor will be anchored into the specified anchor
    ///   - right: current view's right anchor will be anchored into the specified anchor
    ///   - topConstant: current view's top anchor margin
    ///   - leftConstant: current view's left anchor margin
    ///   - bottomConstant: current view's bottom anchor margin
    ///   - rightConstant: current view's right anchor margin
    ///   - widthConstant: current view's width
    ///   - heightConstant: current view's height
    /// - Returns: array of newly added constraints (if applicable).
    @discardableResult
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        rightConstant: CGFloat = 0,
        widthConstant: CGFloat = 0,
        heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }

        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }

        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }

        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }

        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }

        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }

        anchors.forEach({$0.isActive = true})

        return anchors
    }

    /// SwifterSwift: Anchor center X into current view's superview with a constant margin value.
    ///
    /// - Parameter constant: constant of the anchor constraint (default is 0).
    func anchorCenterXToSuperview(constant: CGFloat = 0) {
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }

    /// SwifterSwift: Anchor center Y into current view's superview with a constant margin value.
    ///
    /// - Parameter withConstant: constant of the anchor constraint (default is 0).
    func anchorCenterYToSuperview(constant: CGFloat = 0) {
        // https://videos.letsbuildthatapp.com/
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }

    /// SwifterSwift: Anchor center X and Y into current view's superview
    func anchorCenterSuperview() {
        // https://videos.letsbuildthatapp.com/
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }

    /// SwifterSwift: Search all superviews until a view with the condition is found.
    ///
    /// - Parameter predicate: predicate to evaluate on superviews.
    func ancestorView(where predicate: (UIView?) -> Bool) -> UIView? {
        if predicate(superview) {
            return superview
        }
        return superview?.ancestorView(where: predicate)
    }

    /// SwifterSwift: Search all superviews until a view with this class is found.
    ///
    /// - Parameter name: class of the view to search.
    func ancestorView<T: UIView>(withClass name: T.Type) -> T? {
        return ancestorView(where: { $0 is T }) as? T
    }
    
}
