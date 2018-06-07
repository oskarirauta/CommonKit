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
            let popOver: PopOver = PopOverExample(from: self.button, size: CGSize(width: 120.0, height: 45.0), arrowDirection: .up)
            self.present(popOver, animated: true, completion: nil)
            
        case 1: // Popover with automatic constraints, view with subviews
            let popOver: PopOver = PopOverAutosize(from: self.button2, size: .zero, arrowDirection: .down)
            self.present(popOver, animated: true, completion: nil)
            
        case 2: // Popover with automatic constraints, single view without subviews
            let popOver: PopOver = PopOverAutosize2(from: self.button3, size: .zero, arrowDirection: .down)
            self.present(popOver, animated: true, completion: nil)
            
        case 3: // Popover with automatic constraints and dynamicly created content
            let popOver: PopOver = PopOverAutosize3(from: self.button4, size: .zero, arrowDirection: .down).properties {
                $0.contentView = UILabel.create {
                    $0.translatesAutoresizingMaskIntoConstraints = false
                    $0.font = UIFont.boldSystemFont(ofSize: 13.5)
                    $0.textColor = UIColor.black
                    $0.text = "Hello World!"
                }
                $0.setupView()
                $0.setupConstraints()
            }
            self.present(popOver, animated: true, completion: nil)
            
        default: doNothing()
        }
        
    }
    
    
}
