//
//  CLPlacemark.swift
//  CommonKit
//
//  Created by Oskari Rauta on 06/12/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import CoreLocation

public extension CLPlacemark {
    
    public func roughlyEqual(with anotherPlace: CLPlacemark?) -> Bool {
        guard
            let _place: CLPlacemark = anotherPlace,
            _place.name == self.name,
            _place.isoCountryCode == self.isoCountryCode,
            _place.country == self.country,
            _place.postalCode == self.postalCode,
            _place.administrativeArea == self.administrativeArea,
            _place.subAdministrativeArea == self.subAdministrativeArea,
            _place.locality == self.locality,
            _place.subLocality == self.subLocality,
            _place.ocean == self.ocean,
            _place.inlandWater == self.inlandWater
            else { return false }
        return true
    }
    
    
}
