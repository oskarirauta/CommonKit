//
//  BarCode_ImageView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 13/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView {
    
    /// Creates a new image view with the given BarCode
    ///
    /// - parameter barCode:      The BarCode to display in the image view
    convenience init(barCode: BarCode) {
        self.init(image: barCode.image)
    }
    
}
