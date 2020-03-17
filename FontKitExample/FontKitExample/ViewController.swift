//
//  ViewController.swift
//  FontKitExample
//
//  Created by Oskari Rauta on 07/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit
import CommonKit

class ViewController: UIViewController {
    
    var label: [UILabel.TitleLabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...4 {
            let _label: UILabel.TitleLabel = UILabel.TitleLabel.´default´.properties {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.iconMargin = i == 3 ? 5.0 : 1.0
            }
            self.label.append(_label)
            self.view.addSubview(label[i])
            self.label[i].centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.label[i].leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0).isActive = true
            self.label[i].topAnchor.constraint(equalTo: i == 0 ? self.view.safeAreaLayoutGuide.topAnchor : self.label[i-1].bottomAnchor, constant: 20.0).isActive = true
        }
        
        label[0].icon = FontAwesome.brands.apple
        label[0].title = "Font Awesome: Brands: Apple"
        
        label[1].icon = "fas-audio-description"
        label[1].title = "Font Awesome: *Solid: audio-description"
        
        label[2].icon = "far:calendarCheck"
        label[2].title = "Font Awesome: Regular: calendarCheck"
        
        label[3].icon = MaterialIcons.airportShuttle
        label[3].title = "MaterialIcons: *Regular: airportShuttle"

        label[4].icon = FoundationIcons.power
        label[4].title = "FoundationIcons: *Regular: power"
 
    }
    
}
