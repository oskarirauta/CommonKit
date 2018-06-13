//
//  Barcode.swift
//  CommonKit
//
//  Created by Oskari Rauta on 13/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

/// BarCode generator
public struct BarCode {
    
    /// Data contained in the generated BarCode
    public let data: Data
    
    /// Foreground color of the output
    /// Defaults to black
    public var color = CIColor(red: 0, green: 0, blue: 0)
    
    /// Background color of the output
    /// Defaults to transparent
    public var backgroundColor = CIColor(red: 1, green: 1, blue: 1)
    
    // MARK: Init
    
    public init(data: Data) {
        self.data = data
    }
    
    public init?(string: String, encoding: String.Encoding = .utf8, allowLossyConversion: Bool = false) {
        guard let data = string.data(using: encoding, allowLossyConversion: allowLossyConversion) else { return nil }
        self.data = data
    }
    
    public init?(url: URL, encoding: String.Encoding = .utf8, allowLossyConversion: Bool = false) {
        guard let data = url.absoluteString.data(using: encoding, allowLossyConversion: allowLossyConversion) else { return nil }
        self.data = data
    }
    
    // MARK: Generate BarCode
    
    /// The BarCode's UIImage representation
    public var image: UIImage? {
        
        guard
            let ciImage = ciImage,
            let image = ciImage.nonInterpolatedImage else { return nil }
        return image
    }
    
    /// The BarCode's CIImage representation
    public var ciImage: CIImage? {
        // Generate BarCode
        guard let barcodeFilter = CIFilter(name: "CICode128BarcodeGenerator") else { return nil }
        
        barcodeFilter.setDefaults()
        barcodeFilter.setValue(data, forKey: "inputMessage")
        
        // Color code and background
        guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
        
        colorFilter.setDefaults()
        colorFilter.setValue(barcodeFilter.outputImage, forKey: "inputImage")
        colorFilter.setValue(color, forKey: "inputColor0")
        colorFilter.setValue(backgroundColor, forKey: "inputColor1")
        
        return colorFilter.outputImage
    }
}
