//
//  UIFont.swift
//  CommonKit
//
//  Created by Oskari Rauta on 06/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension UIFont {
    
    var bold: UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits(.traitBold)!, size: 0)
    }
    
    var italic: UIFont {
        return UIFont(descriptor: self.fontDescriptor.withSymbolicTraits(.traitItalic)!, size: 0)
    }
    
    /// SwifterSwift: Font as monospaced font
    ///
    ///     UIFont.preferredFont(forTextStyle: .body).monospaced
    ///
    var monospaced: UIFont {
        let settings = [[UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType, UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector]]

        let attributes = [UIFontDescriptor.AttributeName.featureSettings: settings]
        let newDescriptor = fontDescriptor.addingAttributes(attributes)
        return UIFont(descriptor: newDescriptor, size: 0)
    }
    
}
