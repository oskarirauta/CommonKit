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

public extension CharacterSet {
    func contains(_ character: Character) -> Bool {
        let string: String = String(character)
        return string.rangeOfCharacter(from: self, options: [], range: string.startIndex..<string.endIndex) != nil
    }
}

public extension String {
    
    var length: Int { get { return self.count }}
    
    var string: String { get { return self }}

    var lastPathComponent: String { get { return (self as NSString).lastPathComponent }}
    
    var pathExtension: String {
        get { return (self as NSString).pathExtension }}

    var stringByDeletingLastPathComponent: String {
        get { return (self as NSString).deletingLastPathComponent }}
    
    var stringByDeletingPathExtension: String {
        get { return (self as NSString).deletingPathExtension }}
    
    var pathComponents: [String] {
        get { return (self as NSString).pathComponents }}
    
    func stringByAppendingPathComponent(path: String) -> String {
        return (self as NSString).appendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(ext: String) -> String? {
        return (self as NSString).appendingPathExtension(ext)
    }
    
    var emptyNil: String? {
        get { return self.isEmpty ? nil : self }}

    var isValidEmail: Bool {
        get {
            // here, `try!` will always succeed because the pattern is valid
            let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
    }
    
    func replacingOccurrences(of: [String : String] ) -> String {
        var ret: String = self
        
        for (key, replacement) in of {
            ret = ret.replacingOccurrences(of: key, with: replacement)
        }
        return ret
    }
    
    var htmlFormat: String {
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
    
    var base64Decoded: String? {
        get {
            guard let decodedData = Data(base64Encoded: self) else { return nil }
            return String(data: decodedData, encoding: .utf8)
        }
    }
    
    var base64Encoded: String? {
        get { return self.data(using: .utf8)?.base64EncodedString() ?? nil }
    }
    
    var isEmail: Bool {
        get { return self.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                         options: .regularExpression, range: nil, locale: nil) != nil }
    }
    
    var url: URL? {
        get { return URL(string: self) }
    }
    
    var trimmed: String {
        get { return self.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
    
    var urlDecoded: String {
        get { return self.removingPercentEncoding ?? self }
    }
    
    var urlEncoded: String {
        get { return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! }
    }
    
    var withoutSpacesAndNewLines: String {
        get { return self.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "") }
    }
    
    var isWhitespace: Bool {
        get { return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }
    
    var isSpelledCorrectly: Bool {
        get {
            let checker = UITextChecker()
            let range = NSRange(location: 0, length: utf16.count)

            let misspelledRange = checker.rangeOfMisspelledWord(in: self, range: range, startingAt: 0, wrap: false, language: Locale.preferredLanguages.first ?? "en")
            return misspelledRange.location == NSNotFound
        }
    }
    
    init?(base64: String) {
        guard let decodedData = Data(base64Encoded: base64) else { return nil }
        guard let str = String(data: decodedData, encoding: .utf8) else { return nil }
        self.init(str)
    }
    
    func substring(from: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        return String(self[start ..< endIndex])
    }
    
    func substring(to: Int) -> String {
        let end = index(endIndex, offsetBy: -to)
        return String(self[startIndex ..< end])
    }
    
    func substring(from: Int, maxLength: Int) -> String {
        return String(self.substring(from: from).prefix(maxLength))
    }
    
    subscript(i: Int) -> Character? {
        guard i >= 0 && i < count else { return nil }
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript(safe range: CountableRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else { return nil }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else { return nil }
        return String(self[lowerIndex..<upperIndex])
    }
    
    subscript(safe range: ClosedRange<Int>) -> String? {
        guard let lowerIndex = index(startIndex, offsetBy: max(0, range.lowerBound), limitedBy: endIndex) else { return nil }
        guard let upperIndex = index(lowerIndex, offsetBy: range.upperBound - range.lowerBound + 1, limitedBy: endIndex) else { return nil }
        return String(self[lowerIndex..<upperIndex])
    }
    
    subscript(r: CountableClosedRange<Int>) -> String? {
        get {
            guard r.lowerBound >= 0, let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound, limitedBy: self.endIndex),
                let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound, limitedBy: self.endIndex) else { return nil }
            return String(self[startIndex...endIndex])
        }
    }
    
    func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        return ( !caseSensitive ? self.range(of: string, options: .caseInsensitive) : range(of: string)) != nil
    }
    
    func replacingCharacters(in: NSRange, with: String) -> String? {
        return (self as NSString).replacingCharacters(in: `in`, with: with)
    }
    
    func charAt(_ i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    @discardableResult mutating func remove() -> String {
        let ret: String = self
        self = ""
        return ret
    }
    
    func fillLeading(until length: Int, with: String) -> String {
        var ret: String = self
        while ( ret.length < length ) {
            ret = with + ret
        }
        return ret
    }
    
    func fillTrailing(until length: Int, with: String) -> String {
        var ret: String = self
        while ( ret.length < length ) {
            ret += with
        }
        return ret
    }
    
    func allowed(characters `in`: String) -> String {
        return self.filter({ String($0).rangeOfCharacter(from: CharacterSet(charactersIn: `in`)) != nil })
    }
    
    var urlrequest: URLRequest? {
        get {
            guard let url: URL = self.url else { return nil }
            return URLRequest(url: url)
        }
    }
    
    var lines: [String] {
        get {
            var ret: [String] = [String]()
            self.enumerateLines { (line, _) -> () in
                ret.append(line)
            }
            return ret
        }
    }
    
    func minLines(num: Int) -> String {
        var lines: Array<String> = self.lines
        while lines.count < num { lines.append("") }
        return lines.combined
    }
    
    var firstUppercased: String {
        guard let first = self.first else { return "" }
        return String(first).uppercased() + self.dropFirst()
    }
    
    var reversed: String {
        get { return String(self.reversed()) }
    }
    
    func separate(every: Int, with separator: String) -> String {
        return String(stride(from: 0, to: Array(self).count, by: every).map {
            Array(Array(self)[$0..<min($0 + every, Array(self).count)])
            }.joined(separator: separator))
    }
    
    func minimumLength(of count: Int, filler: Character) -> String {
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

public extension Array where Element == String {

    var lowercased: [String] {
        get { return self.map { $0.lowercased() } }
    }
    
    var uppercased: [String] {
        get { return self.map { $0.uppercased() } }
    }
    
}

public extension Substring {
    
    var string: String {
        get { return String(self) }
    }    
}
