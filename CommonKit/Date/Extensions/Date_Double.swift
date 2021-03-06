//
//  Date_Double.swift
//  CommonKit
//
//  Created by Oskari Rauta on 06/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension Double {
    
    init(hour: Int, minute: Int) {
        self = Double(hour) + ( Double(minute) / 100 )
    }
    
    var hour: Int {
        return Int(self)
    }
    
    var minute: Int {
        return Int((self - Double(Int(self))) * 100)
    }
    
    var clock_minute: Int {
        return self.minute == 0 ? 0 : ( self.minute == 25 ? 15 : ( self.minute == 50 ? 30 : 45 ))
    }

}
