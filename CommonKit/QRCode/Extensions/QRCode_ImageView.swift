//
//  QRCode_ImageView.swift
//  CommonKit
//
//  Created by Oskari Rauta on 13/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView {
    
    /// Creates a new image view with the given QRCode
    ///
    /// - parameter qrCode:      The QRCode to display in the image view
    convenience init(qrCode: QRCode) {
        self.init(image: qrCode.image)
    }
    
}
