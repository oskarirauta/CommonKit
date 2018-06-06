//
//  FontType.swift
//  FontKit
//
//  Created by Oskari Rauta on 18/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public typealias FontCompatible = Optional<Any & CustomFontConvertible>

public protocol FontDetails {
    var fontNo: Int { get }
    var prefix: String { get }
    var fontGroup: String { get }
    var fontEnum: String { get }
    var fontFamily: String { get }
    var fontName: String { get }
    var fontResource: String { get }
    var fontFormat: String { get }
    var fontWidthFactor: CGFloat { get }
    var fontHeightFactor: CGFloat { get }
}

public protocol FontType: FontDetails, CustomFontConvertible {
    var description: String { get }

    init?(prefix: String)
    func icon(named: String) -> IconType?
    func font(ofSize: CGFloat) -> UIFont?
    func isEqual(to: FontType?) -> Bool
    func size(for fontSize: CGFloat) -> CGSize
}

extension FontType {
    
    public func isEqual(to: FontType?) -> Bool {
        return ((( self.convertedFont == nil ) && ( to == nil )) || (( self.convertedFont != nil ) && ( to != nil ))) && ( self.convertedFont?.fontName == to?.fontName )
    }
}

public protocol CustomFontConvertible {
    var convertedFont: FontType? { get }
    func isEqual(to: FontType?) -> Bool
}

extension CustomFontConvertible {
    
    public func isEqual(to: FontType?) -> Bool {
        return ((( self.convertedFont == nil ) && ( to == nil )) || (( self.convertedFont != nil ) && ( to != nil ))) && ( self.convertedFont?.fontName == to?.fontName )
    }

}

extension String: CustomFontConvertible {
    public var convertedFont: FontType? {
        return Font(prefix: self.lowercased())
    }
}
