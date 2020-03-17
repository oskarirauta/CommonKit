//
//  MinuteIntervalMode.swift
//  DateKit
//
//  Created by Oskari Rauta on 08/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public enum MinuteIntervalMode: Int {
    case none = 0
    case quarter = 15
    case half = 30
    
    public var simpleDescription: String {
        switch self {
        case .none: return "No interval"
        case .quarter: return "15 minutes interval"
        case .half: return "30 minutes interval"
        }
    }
    
    public var values: [MinuteIntervalMode] {
        return [.none, .quarter, .half]
    }
}
