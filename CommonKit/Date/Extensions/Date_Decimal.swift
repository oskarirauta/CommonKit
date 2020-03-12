//
//  Date_Decimal.swift
//  CommonKit
//
//  Created by Oskari Rauta on 27/08/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension Decimal {
    
    init(hour: Int, minute: Int) {
        self = Decimal(hour) + ( Decimal(minute) / 100 )
    }
    
    var hour: Int {
        get { return Int(self.intValue) }
    }
    
    var minute: Int {
        get { return Int(((self - Decimal(Int(self.intValue))) * 100).intValue) }
    }
    
    var clock_minute: Int {
        get { return self.minute == 0 ? 0 : ( self.minute == 25 ? 15 : ( self.minute == 50 ? 30 : 45 )) }
    }
    
}
