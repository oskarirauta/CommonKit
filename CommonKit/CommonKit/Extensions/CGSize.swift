//
//  CGSize.swift
//  CommonKit
//
//  Created by Oskari Rauta on 05/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension CGSize {
    
    public func grow(width: CGFloat, height: CGFloat) -> CGSize {
        return CGSize(width: self.width + width, height: self.height + height)
    }

    public func grow(width: Double, height: Double) -> CGSize {
        return CGSize(width: self.width + CGFloat(width), height: self.height + CGFloat(height))
    }

    public func grow(width: Int, height: Int) -> CGSize {
        return CGSize(width: self.width + CGFloat(width), height: self.height + CGFloat(height))
    }

    
}
