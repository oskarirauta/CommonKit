//
//  FontEnum.swift
//  FontKit
//
//  Created by Oskari Rauta on 18/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public protocol FontEnum: FontType, CaseIterable, RawRepresentable where RawValue == String {
    static var fonts: [IconType.Type] { get }
}

extension FontEnum {
    public var fontNo: Int { return Int(self.rawValue.components(separatedBy: ",")[0])! }
    public var prefix: String { return self.rawValue.components(separatedBy: ",")[1] }
    public var fontGroup: String { return self.rawValue.components(separatedBy: ",")[2] }
    public var fontEnum: String { return self.rawValue.components(separatedBy: ",")[3] }
    public var fontFamily: String { return self.rawValue.components(separatedBy: ",")[4] }
    public var fontName: String { return self.rawValue.components(separatedBy: ",")[5] }
    public var fontResource: String { return self.rawValue.components(separatedBy: ",")[6]}
    public var fontFormat: String { return self.rawValue.components(separatedBy: ",")[7] }
    public var fontWidthFactor: CGFloat { return CGFloat(NumberFormatter().number(from: self.rawValue.components(separatedBy: ",")[8])!.floatValue) }
    public var fontHeightFactor: CGFloat { return CGFloat(NumberFormatter().number(from: self.rawValue.components(separatedBy: ",")[9])!.floatValue) }

    public var description: String { return self.rawValue }
    
    public var convertedFont: FontType? {
        return self
    }

    public init?(rawValue: Self.RawValue) {
        let lname: String = rawValue.lowercased()
        guard let font = Self.allCases.first(where: { $0.prefix == lname }) else { return nil }
        self = font
    }

    public init?(prefix: String) {
        let lname: String = prefix.lowercased()
        guard let font = Self.allCases.first(where: { $0.prefix == lname }) else { return nil }
        self = font
    }
    
    public init?(fontNo: Int) {
        guard let font = Self.allCases.first(where: { $0.fontNo == fontNo }) else { return nil }
        self = font
    }
    
    public func icon(named: String) -> IconType? {
        guard let index = Self.allCases.sorted(by: { $0.fontNo < $1.fontNo }).firstIndex(where: { $0 == self }) else { return nil }
        return Self.fonts[index].init(named: named)
    }

    public func font(ofSize: CGFloat) -> UIFont? {
        return UIFont.loadFont(self.fontName, size: ofSize, resource: self.fontResource, ext: self.fontFormat, bundle: Bundle(for: UILabel.TitleLabel.self))
    }

    public func size(for fontSize: CGFloat) -> CGSize {
        return CGSize(width: (self.fontWidthFactor * fontSize * 2).rounded(.up) * 0.5, height: (self.fontHeightFactor * fontSize * 2).rounded(.up) * 0.5)
    }

}
