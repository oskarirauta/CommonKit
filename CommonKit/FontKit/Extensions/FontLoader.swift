//
//  FontLoader.swift
//  FontKit
//
//  Created by Oskari Rauta on 08/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension UIFont {
    
    @discardableResult class func loadFont(_ name: String, size: CGFloat, resource: String, ext: String = "otf", bundle: Bundle? = nil, subdirectory: String? = nil ) -> UIFont? {

        guard let font: UIFont = UIFont(name: name, size: size) else {
            let bundle = bundle ?? Bundle.main
            let fontURL: URL = bundle.url(forResource: resource, withExtension: ext, subdirectory: subdirectory)!
            
            guard
                let data: Data = try? Data(contentsOf: fontURL),
                let provider: CGDataProvider = CGDataProvider(data: data as CFData),
                let font: CGFont = CGFont(provider)
                else { return nil }
            
            var error: Unmanaged<CFError>?
            if ( !CTFontManagerRegisterGraphicsFont(font, &error)) {
                let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
                guard let nsError = error?.takeUnretainedValue() as AnyObject as? NSError else { return UIFont(name: name, size: size) }
                NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
            }

            return UIFont(name: name, size: size)
        }
        
        return font
    }

    @discardableResult func fontSize(_ size: CGFloat) -> UIFont? {
        return UIFont(name: self.fontName, size: size)
    }
    
}
