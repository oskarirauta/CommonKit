//
//  LocationDelegate.swift
//  CommonKit
//
//  Created by Oskari Rauta on 06/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CoreLocation

extension LocationService {
    
    public class LocationDelegate: NSObject, CLLocationManagerDelegate {
        
        open var handler: ((CLPlacemark) -> ())? = nil { didSet { self.lastLocation = nil }}
        open var errorHandler: ((Error) -> ())? = nil
        open var authorizationHandler: ((CLAuthorizationStatus) -> ())? = nil
        
        internal var timer: Timer? = nil
        open internal(set) var lastLocation: CLPlacemark? = nil
        
        public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {
                placemarks, error in
                
                guard error == nil, self.handler != nil, !placemarks.isEmpty, let placemark: CLPlacemark = placemarks?.first, !placemark.roughlyEqual(with: self.lastLocation) else { return }
                
                self.lastLocation = placemark
                
                self.timer?.invalidate()
                self.timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: {
                    timer in
                    if timer.isValid, let placemark: CLPlacemark = self.lastLocation {
                        self.handler?(placemark)
                    }
                })
            })
            
        }
        
        public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            self.errorHandler?(error)
        }
        
        public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            self.authorizationHandler?(status)
        }
        
        public func reset() {
            self.timer?.invalidate()
            self.timer = nil
            self.lastLocation = nil
            self.authorizationHandler = nil
            self.errorHandler = nil
            self.handler = nil
        }
        
    }

    
}
