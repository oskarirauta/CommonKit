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
        if #available(iOS 11, *) {
            offset.y = -adjustedContentInset.top
        } else {
            offset.y = -contentInset.top
        }
        setContentOffset(offset, animated: animated)
    }
}
