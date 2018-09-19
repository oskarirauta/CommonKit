//
//  CameraButton.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//
//  Original:
//      Created by Olivier Destrebecq on 1/16/16.
//      Copyright © 2016 MobDesign. All rights reserved.
//

import Foundation
import UIKit

open class CameraButton: UIButton {
    
    internal let width: CGFloat = 66;
    internal let height: CGFloat = 66;
    
    //create a new layer to render the various circles
    open var pathLayer:CAShapeLayer!
    
    override open var intrinsicContentSize: CGSize {
        get { return CGSize(width: width, height: height) }
    }
    
    open var currentInnerPath: UIBezierPath {
        get { return self.isSelected ? self.innerSquarePath : self.innerCirclePath }
    }
    
    open var innerCirclePath: UIBezierPath {
        get { return UIBezierPath(roundedRect: CGRect(x:8, y:8, width:50, height:50), cornerRadius: 25) }
    }
    
    open var innerSquarePath: UIBezierPath {
        get { return UIBezierPath(roundedRect: CGRect(x:12, y:12, width:42.5, height:42.5), cornerRadius: 21) }
    }
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    //common set up code
    internal func setup() {
        
        //add a shape layer for the inner shape to be able to animate it
        self.pathLayer = CAShapeLayer()
        
        //show the right shape for the current state of the control
        self.pathLayer.path = self.currentInnerPath.cgPath
        
        //don't use a stroke color, which would give a ring around the inner circle
        self.pathLayer.strokeColor = nil
        
        //set the color for the inner shape
        self.pathLayer.fillColor = UIColor.white.cgColor
        
        //add the path layer to the control layer so it gets drawn
        self.layer.addSublayer(self.pathLayer)
        
        //lock the size to match the size of the camera button
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        //clear the title
        self.setTitle("", for:UIControl.State.normal)
        
        //add out target for event handling
        self.addTarget(self, action: #selector(touchUpInside), for: [UIControl.Event.touchUpInside, UIControl.Event.touchCancel, UIControl.Event.touchDragExit, UIControl.Event.touchUpOutside, UIControl.Event.touchDragOutside])
        self.addTarget(self, action: #selector(touchDown), for: [UIControl.Event.touchDown, UIControl.Event.touchDragEnter])
    }
    
    override open var isSelected: Bool {
        didSet {
            //change the inner shape to match the state
            let morph = CABasicAnimation(keyPath: "path")
            morph.duration = self.isSelected ? 0.18 : 0.1
            morph.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            
            //change the shape according to the current state of the control
            morph.toValue = self.currentInnerPath.cgPath
            
            //ensure the animation is not reverted once completed
            morph.fillMode = CAMediaTimingFillMode.forwards
            morph.isRemovedOnCompletion = false
            
            //add the animation
            self.pathLayer.add(morph, forKey:"")
        }
    }
    
    @objc open func touchUpInside(sender:UIButton) {
        self.isSelected = false
    }
    
    @objc open func touchDown(sender:UIButton) {
        self.isSelected = true
    }
    
    override open func draw(_ rect: CGRect) {
        //always draw the outer ring, the inner control is drawn during the animations
        let outerRing = UIBezierPath(ovalIn: CGRect(x:3, y:3, width:60, height:60))
        outerRing.lineWidth = 6
        UIColor.white.setStroke()
        outerRing.stroke()
    }
}
