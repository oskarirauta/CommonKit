//
//  IconEnum.swift
//  FontKit
//
//  Created by Oskari Rauta on 19/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public protocol TypeInstance {
    typealias SelfType = Self.Type
    static var typeInstance: SelfType { get }
}

extension TypeInstance {
    public static var typeInstance: SelfType { return Self.self }
}

public protocol IconEnum: IconType, CaseIterable, TypeInstance, RawRepresentable where Self.RawValue == String {
    static func font(ofSize: CGFloat) -> UIFont?
}

extension IconEnum {
    public static var fontNo: Int { return self.fontType.fontNo }
    public static var prefix: String { return self.fontType.prefix }
    public static var fontGroup: String { return self.fontType.fontGroup }
    public static var fontEnum: String { return self.fontType.fontEnum }
    public static var fontFamily: String { return self.fontType.fontFamily }
    public static var fontName: String { return self.fontType.fontName }
    public static var fontResource: String { return self.fontType.fontResource }
    public static var fontFormat: String { return self.fontType.fontFormat }
    public static var fontWidthFactor: CGFloat { return self.fontType.fontWidthFactor }
    public static var fontHeightFactor: CGFloat { return self.fontType.fontHeightFactor }

    public var fontType: Font { return Self.fontType }
    public var fontNo: Int { return Self.fontNo }
    public var prefix: String { return Self.prefix }
    public var fontGroup: String { return Self.fontGroup }
    public var fontEnum: String { return Self.fontEnum }
    public var fontFamily: String { return Self.fontFamily }
    public var fontName: String { return Self.fontName }
    public var fontResource: String { return Self.fontResource }
    public var fontFormat: String { return Self.fontFormat }
    public var fontWidthFactor: CGFloat { return Self.fontWidthFactor }
    public var fontHeightFactor: CGFloat { return Self.fontHeightFactor }

    public var enumName: String {
        var _enumName: String = ""
        for (index,word) in self.name.split(separator: "-").enumerated() {
            _enumName += index == 0 ? word : ( word.prefix(1).uppercased() + word.dropFirst() )
        }
        return _enumName
    }
    public var name: String { return self.rawValue.components(separatedBy: " ")[0] }
    public var unichar: UInt16 { return self.rawValue.utf16.last! }
    public var scalar: UnicodeScalar { return UnicodeScalar(self.unichar)! }
    
    public var description: String {
        return self.rawValue
    }
    
    public var convertedIcon: IconType? {
        return self
    }

    public var convertedFont: FontType? {
        return Self.fontType
    }
    
    public init?(rawValue: Self.RawValue) {
        let lname: String = rawValue.lowercased()
        guard let icon = Self.allCases.first(where: { $0.name == lname || $0.enumName.lowercased() == lname }) else { return nil }
        self = icon
    }
    
    public init?(named: String) {
        let lname: String = named.lowercased()
        guard let icon = Self.allCases.first(where: { $0.name == lname || $0.enumName.lowercased() == lname }) else { return nil }
        self = icon
    }
    
    public static func font(ofSize: CGFloat) -> UIFont? {
        return self.fontType.font(ofSize: ofSize)
    }

    public func font(ofSize: CGFloat) -> UIFont? {
        return Self.font(ofSize: ofSize)
    }
}
