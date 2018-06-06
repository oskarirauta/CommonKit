//
//  General.swift
//  MathKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public func floor2(_ value: Double) -> Double {
    return ((floor(value * 2)) * 0.5)
}

public func floor2(_ value: Float) -> Float {
    return ((floor(value * 2)) * 0.5)
}

public func floor2(_ value: CGFloat) -> CGFloat {
    return ((floor(value * 2)) * 0.5)
}

public func ceil2(_ value: Double) -> Double {
    return ((ceil(value * 2)) * 0.5)
}

public func ceil2(_ value: Float) -> Float {
    return ((ceil(value * 2)) * 0.5)
}

public func ceil2(_ value: CGFloat) -> CGFloat {
    return ((ceil(value * 2)) * 0.5)
}
