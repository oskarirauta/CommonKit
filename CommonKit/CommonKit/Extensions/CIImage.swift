//
//  CIImage.swift
//  CommonKit
//
//  Created by Oskari Rauta on 13/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

public extension CIImage {
    
    var nonInterpolatedImage: UIImage? {
        get {
            guard let cgImage = CIContext(options: nil).createCGImage(self, from: self.extent) else { return nil }
            let size = CGSize(width: self.extent.size.width, height: self.extent.size.height)
            UIGraphicsBeginImageContextWithOptions(size, true, 0)
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            context.interpolationQuality = .none
            context.translateBy(x: 0, y: size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.draw(cgImage, in: context.boundingBoxOfClipPath)
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return result
        }
    }
}
