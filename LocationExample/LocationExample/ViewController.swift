//
//  ViewController.swift
//  LocationExample
//
//  Created by Oskari Rauta on 31.03.19.
//  Copyright © 2019 Oskari Rauta. All rights reserved.
//

import UIKit
import CommonKit
import CoreLocation

class ViewController: UIViewController {

    var placemark: CLPlacemark? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.placemark = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        LocationService.requestWhenInUseAuthorization()
        
        LocationService.reset()
        LocationService.locationValidationTimeout = 1.0
        LocationService.accuracy = kCLLocationAccuracyKilometer
        LocationService.handler = self.updateLocation
        LocationService.startUpdating()

        waitWhile(condition: { return self.placemark != nil }, completion: {
            print("Got location")
            if self.placemark != nil {
                print("Country: " + ( self.placemark?.country ?? "nil"))
            }
        })
 
    }

    func updateLocation(_ placemark: CLPlacemark) {
        self.placemark = placemark
        //print("Country: " + ( self.placemark?.country ?? "nil"))
    }
    
}

