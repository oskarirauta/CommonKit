//
//  ViewController.swift
//  LabelExample
//
//  Created by Oskari Rauta on 29/08/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit
import CommonKit

class ViewController: UIViewController {

    lazy var roundLabel: UIRoundLabel = UIRoundLabel.create {
        $0.text = "Badge"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.badgeBackgroundColor
        $0.textColor = UIColor.white
        $0.font = UIFont.boldSystemFont(ofSize: 14.5)
        $0.textAlignment = .center
        $0.baselineAdjustment = .alignBaselines
        $0.paddingAdjustment = UIEdgeInsets(top: 0, left: 0.5, bottom: 0.5, right: 0)
    }
    
    lazy var blockLabel: UIBlockLabel = UIBlockLabel.create {
        $0.text = "Block"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.badgeBackgroundColor
        $0.textColor = UIColor.white
        $0.font = UIFont.boldSystemFont(ofSize: 14.5)
        $0.textAlignment = .center
        $0.baselineAdjustment = .alignBaselines
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.roundLabel)
        self.view.addSubview(self.blockLabel)
        
        self.roundLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.roundLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -100.0).isActive = true

        self.blockLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.blockLabel.topAnchor.constraint(equalTo: self.roundLabel.bottomAnchor, constant: 10.0).isActive = true

    }

}

