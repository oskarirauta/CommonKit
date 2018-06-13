//
//  QRCode.swift
//  CommonKit
//
//  Created by Oskari Rauta on 13/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

/// QRCode generator
public struct QRCode {
    
    /**
     The level of error correction.
     
     - Low:      7%
     - Medium:   15%
     - Quartile: 25%
     - High:     30%
     */
    public enum ErrorCorrection: String {
        case Low = "L"
        case Medium = "M"
        case Quartile = "Q"
        case High = "H"
    }
    
    /// Data contained in the generated QRCode
    public let data: Data
    
    /// Foreground color of the output
    /// Defaults to black
    public var color = CIColor(red: 0, green: 0, blue: 0)
    
    /// Background color of the output
    /// Defaults to white
    public var backgroundColor = CIColor(red: 1, green: 1, blue: 1)
    
    /// Size of the output
    public var size: CGSize? = nil
    
    /// The error correction. The default value is `.Low`.
    public var errorCorrection = ErrorCorrection.Low
    
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
    
    // MARK: Generate QRCode
    
    /// The QRCode's UIImage representation
    public var image: UIImage? {
        guard let ciImage = ciImage, let image = ciImage.nonInterpolatedImage else { return nil }
        guard let size = self.size else { return image }
        
        // Size
        let image_size: CGSize = image.size
        
        let widthRatio  = size.width  / image_size.width
        let heightRatio = size.height / image_size.height
        
        let newSize: CGSize = widthRatio > heightRatio ? CGSize(width: image_size.width * heightRatio, height: image_size.height * heightRatio) : CGSize(width: image_size.width * widthRatio,  height: image_size.height * widthRatio)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    /// The QRCode's CIImage representation
    public var ciImage: CIImage? {
        // Generate QRCode
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        
        qrFilter.setDefaults()
        qrFilter.setValue(data, forKey: "inputMessage")
        qrFilter.setValue(self.errorCorrection.rawValue, forKey: "inputCorrectionLevel")
        
        // Color code and background
        guard let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }
        
        colorFilter.setDefaults()
        colorFilter.setValue(qrFilter.outputImage, forKey: "inputImage")
        colorFilter.setValue(color, forKey: "inputColor0")
        colorFilter.setValue(backgroundColor, forKey: "inputColor1")
        
        return colorFilter.outputImage
    }
}
