//
//  String.swift
//  CommonKit
//
//  Created by Oskari Rauta on 26/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol IsEmptyProtocol {
    var isEmpty: Bool { get }
}

extension CharacterSet {
    public func contains(_ character: Character) -> Bool {
        let string = String(character)
        return string.rangeOfCharacter(from: self, options: [], range: string.startIndex..<string.endIndex) != nil
    }
}

extension Optional: IsEmptyProtocol where Wrapped == String {
    
    public var isEmpty: Bool { get { return self?.isEmpty ?? true }}
}

extension String {
    
    public var length: Int { get { return self.count }}
    
    public var string: String { get { return self }}

    public var lastPathComponent: String { get { return (self as NSString).lastPathComponent }}
    
    public var pathExtension: String {
        get { return (self as NSString).pathExtension }}

    public var stringByDeletingLastPathComponent: String {
        get { return (self as NSString).deletingLastPathComponent }}
    
    public var stringByDeletingPathExtension: String {
        get { return (self as NSString).deletingPathExtension }}
    
    public var pathComponents: [String] {
        get { return (self as NSString).pathComponents }}
    
    public func stringByAppendingPathComponent(path: String) -> String {
        return (self as NSString).appendingPathComponent(path)
    }
    
    public func stringByAppendingPathExtension(ext: String) -> String? {
        return (self as NSString).appendingPathExtension(ext)
    }
    
    public var emptyNil: String? {
        get { return self.isEmpty ? nil : self }}

    public var isValidEmail: Bool {
        get {
            // here, `try!` will always succeed because the pattern is valid
            let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
    }
    
    public func replacingOccurrences(of: [String : String] ) -> String {
        var ret: String = self
        
        for (key, replacement) in of {
            ret = ret.replacingOccurrences(of: key, with: replacement)
        }
        return ret
    }
    
    public var htmlFormat: String {
        get {
            
            let whiteSpaceEntities: [String: String] = [
                "&nbsp;": " ",
                "<br/>": " ",
                "<br>": " ",
                "<BR/>": " ",
                "<BR>": " "
            ]
            
            guard
                !self.replacingOccurrences(of: whiteSpaceEntities).lines.joined().trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return "" }
            
            var ret: String = self
            
            for (replacement, key) in HTMLEntities.primaryEntities {
                ret = ret.replacingOccurrences(of: String(key), with: replacement)
            }
            
            for (replacement, key) in HTMLEntities.xmlEntities {
                ret = ret.replacingOccurrences(of: String(key), with: replacement)
            }
            
            for (replacement, key) in HTMLEntities.characterEntities {
                ret = ret.replacingOccurrences(of: String(key), with: replacement)
            }
            return ret
        }
    }
    
    public func substring(from: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        return String(self[start ..< endIndex])
    }
    
    public func substring(to: Int) -> String {
        let end = index(endIndex, offsetBy: -to)
        return String(self[startIndex ..< end])
    }
    
    public func substring(from: Int, maxLength: Int) -> String {
        return String(self.substring(from: from).prefix(maxLength))
    }
    
    public subscript (r: CountableClosedRange<Int>) -> String? {
        get {
            guard r.lowerBound >= 0, let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound, limitedBy: self.endIndex),
                let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound, limitedBy: self.endIndex) else { return nil }
            return String(self[startIndex...endIndex])
        }
    }
    
    public func replacingCharacters(in: NSRange, with: String) -> String? {
        return (self as NSString).replacingCharacters(in: `in`, with: with)
    }
    
    public func charAt(_ i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    public mutating func remove() -> String {
        let ret: String = self
        self = ""
        return ret
    }
    
    public func fillLeading(until length: Int, with: String) -> String {
        var ret: String = self
        while ( ret.length < length ) {
            ret = with + ret
        }
        return ret
    }
    
    public func fillTrailing(until length: Int, with: String) -> String {
        var ret: String = self
        while ( ret.length < length ) {
            ret += with
        }
        return ret
    }
    
    public func allowed(characters `in`: String) -> String {
        return self.filter({ String($0).rangeOfCharacter(from: CharacterSet(charactersIn: `in`)) != nil })
    }
    
    public var url: URL {
        get { return URL(string: self)! }}
    
    public var urlrequest: URLRequest {
        get { return URLRequest(url: self.url) }}
    
    public var lines: Array<String> {
        get {
            var ret: Array<String> = []
            self.enumerateLines { (line, _) -> () in
                ret.append(line)
            }
            return ret
        }
    }
    
    public func minLines(num: Int) -> String {
        var lines: Array<String> = self.lines
        while lines.count < num { lines.append("") }
        return lines.combined
    }
    
    public var firstUppercased: String {
        guard let first = self.first else { return "" }
        return String(first).uppercased() + self.dropFirst()
    }
    
    public var reversed: String {
        get { return String(self.reversed()) }
    }
    
    public func separate(every: Int, with separator: String) -> String {
        return String(stride(from: 0, to: Array(self).count, by: every).map {
            Array(Array(self)[$0..<min($0 + every, Array(self).count)])
            }.joined(separator: separator))
    }
    
    public func minimumLength(of count: Int, filler: Character) -> String {
        var str: String = self
        while str.count < count { str.append(filler) }
        return str
    }

}

public protocol StringArrayProtocol {
    var combined: String { get }
}

extension Array: StringArrayProtocol where Element == String {
    
    public var combined: String {
        get {
            var ret: String = ""
            for (index, el) in self.enumerated() {
                ret += el + ( index < ( self.count - 1 ) ? "\n" : "" )
            }
            return ret
        }
    }
    
}

extension Array where Element == String {

    public var lowercased: [String] {
        get { return self.map { $0.lowercased() } }
    }
    
    public var uppercased: [String] {
        get { return self.map { $0.uppercased() } }
    }
    
}

extension Range where Bound == String.Index {
    public var nsRange:NSRange {
        get {
            return NSRange(location: self.lowerBound.encodedOffset,
                           length: self.upperBound.encodedOffset -
                            self.lowerBound.encodedOffset)
        }
    }
}

extension Substring {
    
    var string: String {
        get { return String(self) }
    }    
}
