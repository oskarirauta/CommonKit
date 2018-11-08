//
//  CGRect.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/11/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension CGRect {
    
    public func grow(by insets: UIEdgeInsets) -> CGRect {
        return CGRect(x: self.origin.x - insets.left, y: self.origin.y - insets.top, width: self.size.width + ( insets.right * 2.0 ), height: self.size.height + ( insets.bottom * 2.0 ))
    }

    public func grow(by size: CGSize) -> CGRect {
        return CGRect(x: self.origin.x - size.width, y: self.origin.y - size.height, width: self.size.width + ( size.width * 2.0 ), height: self.size.height + ( size.height * 2.0 ))
    }
    
    public func grow(width: Double, height: Double) -> CGRect {
        return self.grow(by: CGSize(width: width, height: height))
    }
    
    public func grow(width: Int, height: Int) -> CGRect {
        return self.grow(by: CGSize(width: CGFloat(width), height: CGFloat(height)))
    }
    
}
