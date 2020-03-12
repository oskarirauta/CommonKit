//
//  NSAttributedString.swift
//  CommonKit
//
//  Created by Oskari Rauta on 20/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

public extension NSAttributedString {

    /// SwifterSwift: Bolded string.
    var bolded: NSAttributedString {
        get {
            return applying(attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
        }
    }

    /// SwifterSwift: Italicized string.
    var italicized: NSAttributedString {
        get {
            return applying(attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
        }
    }
    
    func numberOfLines(with width: CGFloat) -> Int {
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT)))
        let frameSetterRef : CTFramesetter = CTFramesetterCreateWithAttributedString(self as CFAttributedString)
        let frameRef: CTFrame = CTFramesetterCreateFrame(frameSetterRef, CFRangeMake(0, 0), path.cgPath, nil)
        
        guard let lines = CTFrameGetLines(frameRef) as? [CTLine] else { return 0 }
        return lines.count
    }

    func image(definedSize: CGSize? = nil) -> UIImage? {
        var size: CGSize = definedSize ?? self.size()
        size.width = self.size().width < size.width ? self.size().width : size.width
        size.height = self.size().height < size.height ? self.size().height : size.height
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }

    /// get height, Before this, you must set the height of the text firstly
    func getHeight(by fixedWidth: CGFloat) -> CGFloat {
        let h = self.boundingRect(with: CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)), options: [.usesFontLeading , .usesLineFragmentOrigin, .usesDeviceMetrics], context: nil).size.height
        return ceil(h)
    }
    /// get width, Before this, you must set the height of the text firstly
    func getWidth(by fixedHeight: CGFloat) -> CGFloat {
        let w = self.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: fixedHeight), options: [.usesFontLeading , .usesLineFragmentOrigin], context: nil).size.width
        return ceil(w)
    }
    
}

// From Kyohei Ito's AttributedLabel
public extension NSMutableAttributedString {
    
    @discardableResult func addAttribute(_ attr: NSAttributedString.Key, value: AnyObject, range: NSRange? = nil) -> Self {
        let range = range ?? NSRange(location: 0, length: self.length)
        enumerateAttribute(attr, in: range, options: .reverse) { object, range, pointer in
            if object == nil {
                self.addAttributes([attr: value], range: range)
            }
        }
        
        return self
    }
}

// MARK: - Methods
public extension NSAttributedString {

    #if !os(Linux)
    /// SwifterSwift: Applies given attributes to the new instance of NSAttributedString initialized with self object
    ///
    /// - Parameter attributes: Dictionary of attributes
    /// - Returns: NSAttributedString with applied attributes
    fileprivate func applying(attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let copy = NSMutableAttributedString(attributedString: self)
        let range = (string as NSString).range(of: string)
        copy.addAttributes(attributes, range: range)

        return copy
    }
    #endif

    #if canImport(AppKit) || canImport(UIKit)
    /// SwifterSwift: Add color to NSAttributedString.
    ///
    /// - Parameter color: text color.
    /// - Returns: a NSAttributedString colored with given color.
    func colored(with color: UIColor) -> NSAttributedString {
        return applying(attributes: [.foregroundColor: color])
    }
    #endif

    #if !os(Linux)
    /// SwifterSwift: Apply attributes to substrings matching a regular expression
    ///
    /// - Parameters:
    ///   - attributes: Dictionary of attributes
    ///   - pattern: a regular expression to target
    ///   - options: The regular expression options that are applied to the expression during matching. See NSRegularExpression.Options for possible values.
    /// - Returns: An NSAttributedString with attributes applied to substrings matching the pattern
    func applying(attributes: [NSAttributedString.Key: Any],
                  toRangesMatching pattern: String,
                  options: NSRegularExpression.Options = []) -> NSAttributedString {
        guard let pattern = try? NSRegularExpression(pattern: pattern, options: options) else { return self }

        let matches = pattern.matches(in: string, options: [], range: NSRange(0..<length))
        let result = NSMutableAttributedString(attributedString: self)

        for match in matches {
            result.addAttributes(attributes, range: match.range)
        }

        return result
    }

    /// SwifterSwift: Apply attributes to occurrences of a given string
    ///
    /// - Parameters:
    ///   - attributes: Dictionary of attributes
    ///   - target: a subsequence string for the attributes to be applied to
    /// - Returns: An NSAttributedString with attributes applied on the target string
    func applying<T: StringProtocol>(attributes: [NSAttributedString.Key: Any], toOccurrencesOf target: T) -> NSAttributedString {
        let pattern = "\\Q\(target)\\E"

        return applying(attributes: attributes, toRangesMatching: pattern)
    }
    #endif

}

public extension NSAttributedString {
    
    /// SwifterSwift: Add a NSAttributedString to another NSAttributedString.
    ///
    /// - Parameters:
    ///   - lhs: NSAttributedString to add to.
    ///   - rhs: NSAttributedString to add.
    static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        lhs = string
    }

    /// SwifterSwift: Add a NSAttributedString to another NSAttributedString and return a new NSAttributedString instance.
    ///
    /// - Parameters:
    ///   - lhs: NSAttributedString to add.
    ///   - rhs: NSAttributedString to add.
    /// - Returns: New instance with added NSAttributedString.
    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        return NSAttributedString(attributedString: string)
    }

    /// SwifterSwift: Add a NSAttributedString to another NSAttributedString.
    ///
    /// - Parameters:
    ///   - lhs: NSAttributedString to add to.
    ///   - rhs: String to add.
    static func += (lhs: inout NSAttributedString, rhs: String) {
        lhs += NSAttributedString(string: rhs)
    }

    /// SwifterSwift: Add a NSAttributedString to another NSAttributedString and return a new NSAttributedString instance.
    ///
    /// - Parameters:
    ///   - lhs: NSAttributedString to add.
    ///   - rhs: String to add.
    /// - Returns: New instance with added NSAttributedString.
    static func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
        return lhs + NSAttributedString(string: rhs)
    }
    
}
