//
//  UIScrollView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    public func scrollToTop(animated: Bool) {
        var offset = contentOffset
        offset.y = -adjustedContentInset.top
        if  !animated { self.layer.removeAllAnimations() }
        setContentOffset(offset, animated: animated)
    }
    
}
