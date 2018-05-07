//
//  DispatchTime.swift
//  CommonKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension DispatchTime {
    
    public static var now: DispatchTime {
        get { return .now() }
    }
    
    public static var soon: DispatchTime {
        get { return .now() + Double(Int64(0.02 * Double(NSEC_PER_MSEC))) / Double(NSEC_PER_SEC) }
    }
    
    public static var afterKbdAnim: DispatchTime {
        get { return .now() + Double(Int64(1.0 * ( Double(NSEC_PER_SEC) / 3))) }
    }
    
    public static var tooLate: DispatchTime {
        get { return .now() + Double(Int64(1.0 * Double(NSEC_PER_MSEC))) / Double(NSEC_PER_SEC) }
    }
    
    public static var superLate: DispatchTime {
        get { return .now() + Double(Int64(0.5 * Double(NSEC_PER_MSEC))) / Double(NSEC_PER_SEC) }
    }
    
    public static var late: DispatchTime {
        get { return .now() + Double(Int64(0.2 * Double(NSEC_PER_MSEC))) / Double(NSEC_PER_SEC) }
    }
    
}
