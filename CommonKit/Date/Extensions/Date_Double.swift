//
//  Date_Double.swift
//  CommonKit
//
//  Created by Oskari Rauta on 06/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension Double {
    
    public init(hour: Int, minute: Int) {
        self = Double(hour) + ( Double(minute) / 100 )
    }
    
    public var hour: Int {
        get { return Int(self) }
    }
    
    public var minute: Int {
        get { return Int((self - Double(Int(self))) * 100) }
    }
    
    public var clock_minute: Int {
        get { return self.minute == 0 ? 0 : ( self.minute == 25 ? 15 : ( self.minute == 50 ? 30 : 45 )) }
    }

}
