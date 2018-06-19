//
//  ViewController.swift
//  PopOverExample
//
//  Created by Oskari Rauta on 07/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit
import CommonKit

class ViewController: UIViewController {
    
    lazy var button: UIButton = UIButton.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("PopOver", for: UIControlState())
        $0.tag = 0
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        $0.setTitleColor(UIColor.buttonForegroundColor, for: UIControlState())
        $0.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        $0.addTarget(self, action: #selector(self.doPopOver(_:)), for: .touchUpInside)
    }
    
    lazy var button2: UIButton = UIButton.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("PopOver Autosize", for: UIControlState())
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        $0.tag = 1
        $0.setTitleColor(UIColor.buttonForegroundColor, for: UIControlState())
        $0.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        $0.addTarget(self, action: #selector(self.doPopOver(_:)), for: .touchUpInside)
    }
    
    lazy var button3: UIButton = UIButton.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("PopOver Autosize2", for: UIControlState())
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        $0.tag = 2
        $0.setTitleColor(UIColor.buttonForegroundColor, for: UIControlState())
        $0.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        $0.addTarget(self, action: #selector(self.doPopOver(_:)), for: .touchUpInside)
    }
    
    lazy var button4: UIButton = UIButton.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("PopOver Autosize3", for: UIControlState())
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12.0)
        $0.tag = 3
        $0.setTitleColor(UIColor.buttonForegroundColor, for: UIControlState())
        $0.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        $0.addTarget(self, action: #selector(self.doPopOver(_:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.button)
        self.view.addSubview(self.button2)
        self.view.addSubview(self.button3)
        self.view.addSubview(self.button4)
        self.button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 35.0).isActive = true
        self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.button2.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 35.0).isActive = true
        self.button3.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 35.0).isActive = true
        
        self.button2.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -8.0).isActive = true
        
        self.button3.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 8.0).isActive = true
        
        self.button4.topAnchor.constraint(equalTo: self.button3.bottomAnchor, constant: 35.0).isActive = true
        self.button4.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc func doPopOver(_ sender: UIButton) {
        
        switch sender.tag {
        case 0: // Popover with fixed size
            let popOver: PopOver = PopOver(PopOverCustomContent(), from: self.button, arrowDirection: .up, size: CGSize(width: 120.0, height: 45.0))
            popOver.setPadding(0.0)
            self.present(popOver, animated: true, completion: nil)
            
        case 1: // Popover with automatic constraints, view with subviews, padded by contentView
            let popOver: PopOver = PopOver(PopOverCustomContent(), from: self.button2, arrowDirection: .down)
            popOver.setPadding(0.0)
            self.present(popOver, animated: true, completion: nil)
            
        case 2: // Popover with automatic constraints, single view without subviews
            let popOver: PopOver = PopOver(HelloLabel(), from: self.button3, arrowDirection: .down)
            self.present(popOver, animated: true, completion: nil)
            
        case 3: // Popover with automatic constraints and dynamicly created content, custom padding
            let popOver: PopOver = PopOver(UIView(), from: self.button4, arrowDirection: .down).properties {
                $0.setPadding(10.0)
                $0.contentView = HelloLabel()
            }
            self.present(popOver, animated: true, completion: nil)
            
        default: doNothing()
        }
        
    }
    
    
}
