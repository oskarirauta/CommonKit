//
//  UTCDate.swift
//  DateKit
//
//  Created by Oskari Rauta on 09/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public func UTCDate() -> Date {
    return Date().addingTimeInterval(TimeInterval(TimeZone.current.secondsFromGMT()))
}
