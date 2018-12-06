//
//  LocationService.swift
//  CommonKit
//
//  Created by Oskari Rauta on 06/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CoreLocation

public struct LocationService {
    
    private init() { }
    
    static public var accuracy: CLLocationAccuracy? = nil {
        didSet { self.locationManager?.desiredAccuracy = self.accuracy ?? kCLLocationAccuracyKilometer }
    }
    
    static public var handler: ((CLPlacemark) -> ())? {
        get { return self._delegate.handler }
        set { self._delegate.handler = newValue }
    }
    
    static public var errorHandler: ((Error) -> ())? {
        get { return self._delegate.errorHandler }
        set { self._delegate.errorHandler = newValue }
    }
    
    static public var authorizationHandler: ((CLAuthorizationStatus) -> ())? {
        get { return self._delegate.authorizationHandler }
        set { self._delegate.authorizationHandler = newValue }
    }
    
    static public var lastLocation: CLPlacemark? {
        get { return self._delegate.lastLocation }
    }
    
    static public internal(set) var _delegate: LocationDelegate = LocationDelegate()
    
    static internal var _locationManager: CLLocationManager? = nil
    static public var locationManager: CLLocationManager? {
        get {
            guard self._locationManager == nil else { return self._locationManager }
            self._locationManager = CLLocationManager.create {
                $0.delegate = self._delegate
                $0.desiredAccuracy = self.accuracy ?? kCLLocationAccuracyKilometer
            }
            return self._locationManager
        }
        set { self._locationManager = newValue }
    }
    
    static public var authorizationStatus: CLAuthorizationStatus {
        get { return CLLocationManager.authorizationStatus() }
    }
    
    static public func startUpdating() {
        let authStatus: CLAuthorizationStatus = self.authorizationStatus
        guard authStatus == .authorizedWhenInUse || authStatus == .authorizedAlways else { return }
        let _ = self.locationManager
        self.locationManager?.startUpdatingLocation()
    }
    
    static public func stopUpdating() {
        let authStatus: CLAuthorizationStatus = self.authorizationStatus
        guard authStatus == .authorizedWhenInUse || authStatus == .authorizedAlways else { return }
        let _ = self.locationManager
        self.locationManager?.stopUpdatingLocation()
    }
    
    static public func reset() {
        self.stopUpdating()
        self._delegate.reset()
        self.accuracy = nil
        let _ = self.locationManager
    }

}
