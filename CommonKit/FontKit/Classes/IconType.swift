//
//  IconType.swift
//  FontKit
//
//  Created by Oskari Rauta on 19/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public typealias IconCompatible = Optional<Any & CustomIconConvertible>

public protocol IconDetails {
    static var fontType: Font { get }
    static var fontNo: Int { get }
    static var prefix: String { get }
    static var fontGroup: String { get }
    static var fontEnum: String { get }
    static var fontFamily: String { get }
    static var fontName: String { get }
    static var fontResource: String { get }
    static var fontFormat: String { get }
    static var fontWidthFactor: CGFloat { get }
    static var fontHeightFactor: CGFloat { get }

    var fontType: Font { get }
    var enumName: String { get }
    var name: String { get }
    var unichar: UInt16 { get }
    var scalar: UnicodeScalar { get }
}

public protocol IconType: IconDetails, FontDetails, CustomIconConvertible, CustomFontConvertible {
    var description: String { get }
    var text: String { get }
    
    init?(named: String)
    static func size(for fontSize: CGFloat) -> CGSize

    func font(ofSize: CGFloat) -> UIFont?
    func isEqual(to: IconType?) -> Bool
    func attributedText(ofSize: CGFloat, attributes: [NSAttributedStringKey : Any]) -> NSAttributedString
    func attributedText(ofSize: CGFloat) -> NSAttributedString
    func size(for fontSize: CGFloat) -> CGSize
}

extension IconType {
    
    public var text: String { return String(self.scalar) }
    
    public static func size(for fontSize: CGFloat) -> CGSize {
        return self.fontType.size(for: fontSize)
    }

    public func isEqual(to: IconType?) -> Bool {
        return ((( self.convertedIcon == nil ) && ( to == nil )) || (( self.convertedIcon != nil ) && ( to != nil ))) && ( self.convertedIcon?.unichar == to?.unichar ) && ( self.convertedIcon?.name == to?.name ) && ( self.convertedIcon?.prefix == to?.prefix )
    }

    public func attributedText(ofSize: CGFloat, attributes: [NSAttributedStringKey : Any]) -> NSAttributedString {
        var attrs: [NSAttributedStringKey : Any] = attributes
        if ( attrs[.font] != nil ) { attrs.removeValue(forKey: .font)}
        attrs[.font] = self.font(ofSize: ofSize)!
        return NSAttributedString(string: self.text, attributes: attrs)
    }

    public func attributedText(ofSize: CGFloat) -> NSAttributedString {
        return NSAttributedString(string: String(self.scalar), attributes: [
            .font: self.font(ofSize: ofSize)!
            ])
    }
    
    public func size(for fontSize: CGFloat) -> CGSize {
        return Self.size(for: fontSize)
    }

}

public protocol CustomIconConvertible {
    var convertedIcon: IconType? { get }
    func isEqual(to: IconType?) -> Bool
}

extension CustomIconConvertible {
    public func isEqual(to: IconType?) -> Bool {
        return ((( self.convertedIcon == nil ) && ( to == nil )) || (( self.convertedIcon != nil ) && ( to != nil ))) && ( self.convertedIcon?.unichar == to?.unichar ) && ( self.convertedIcon?.name == to?.name ) && ( self.convertedIcon?.prefix == to?.prefix )
    }

}

extension String: CustomIconConvertible {
    public var convertedIcon: IconType? {
        var prefix: String? = nil
        if ( self.components(separatedBy: " ").count > 1 ) { prefix = self.components(separatedBy: " ")[0]}
        else if ( self.components(separatedBy: ":").count > 1 ) { prefix = self.components(separatedBy: " ")[0]}
        else if ( self.components(separatedBy: "#").count > 1 ) { prefix = self.components(separatedBy: " ")[0]}
        else if ( self.components(separatedBy: "_").count > 1 ) {
            prefix = self.components(separatedBy: "_")[0] }
        else if ( self.components(separatedBy: "-").count > 1 ) {
            prefix = self.components(separatedBy: "-")[0]
        }
        
        guard prefix != nil else { return nil }
        let name: String = String(self.suffix(self.count - ( prefix!.count + 1 ))).replacingOccurrences(of: "_", with: "-").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\r", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        
        return Font(prefix: prefix!)?.icon(named: name)
    }
}
