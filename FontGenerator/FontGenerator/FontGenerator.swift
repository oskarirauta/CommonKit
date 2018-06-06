//
//  FontGenerator.swift
//  FontAwesomeGenerator
//
//  Created by Oskari Rauta on 12/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit
import CoreText
import CommonKit

/*
 Font definition:
 case {prefix} =
                    {variant number} - Index number, starting from 0 which defines base font variant
                    {prefix} - recommended: alphabetic letters, must be in lowercase. No special chars, like !"#€%&/()-_;:\öäå'", avoid numbers as well - keep it simple and short, 3 letters is enough for most. Font is regocnized with this letter set.

                    {fontGroup} - Base for name of which this variant belongs to. This will be identifier for font's name. Keep it simple and without special charaters or spaces.
                    {fontEnum} - this is enum name for font variant. Variant is identified as {fontGroup}.{fontEnum} - once again, keep it simple, no spaces or special chars.
                    {fontFamily} - this should be retrieved from font it self and stored here.
                    {fontName} - this is actual font's name used inside UIFont(named: "{fontName}", ofSize: 13.0)! Get it from loaded fonts.
                    {fontResource} - filename (without extension) of font resource.
                    {fontFormat} - font resource file format, otf, ttf, etc..
 
                    Details are stored as string and separated with single comma(,) - withut spaces between letters and comma, on either side of comma.
 */

public enum fa_fonts: String, FontEnum {
    public static var fonts: [IconType.Type ] { return [] }
    
    case fas = "0,fas,FontAwesome,solid,Font Awesome 5 Free,FontAwesome5FreeSolid,Font Awesome 5 Free-Solid-900,otf"
    case far = "1,far,FontAwesome,regular,Font Awesome 5 Free,FontAwesome5FreeRegular,Font Awesome 5 Free-Regular-400,otf"
    case fab = "2,fab,FontAwesome,brands,Font Awesome 5 Brands,FontAwesome5BrandsRegular,Font Awesome 5 Brands-Regular-400,otf"
}

public enum mat_fonts: String, FontEnum {
    public static var fonts: [IconType.Type ] { return [] }

    case mat = "0,mat,MaterialIcons,regular,Material Icons,MaterialIcons-Regular,MaterialIcons-Regular,ttf"
}

public enum fi_fonts: String, FontEnum {
    public static var fonts: [IconType.Type ] { return [] }
    
    case fi = "0,fi,fontcustom,regular,Foundation Icons,fontcustom,foundation-icons,ttf"

}

extension String {
    
    var iconName: String {
        var ret: String = ""
        for (index,word) in self.split(separator: "-").enumerated() {
            ret += index == 0 ? word : ( word.prefix(1).uppercased() + word.dropFirst() )
        }
        return ret.replacingOccurrences(of: " ", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

class FontGenerator {
    
    class var awesomeFonts: [String: String] {
        get {
            var fonts: [String: String] = [:]
            
            for family in UIFont.familyNames {
                for name in UIFont.fontNames(forFamilyName: family) {
                    guard
                        family.lowercased().contains("font"),
                        family.lowercased().contains("awesome"),
                        !name.isEmpty
                        else { continue }
                    fonts[family] = name
                }
            }

            return fonts
        }
    }
    
    class var materialFonts: [String: String] {
        get {
            var fonts: [String: String] = [:]
            
            for family in UIFont.familyNames {
                for name in UIFont.fontNames(forFamilyName: family) {
                    guard
                        family.lowercased().contains("material"),
                        family.lowercased().contains("icons"),
                        !name.isEmpty
                        else { continue }
                    fonts[family] = name
                }
            }
            
            return fonts
        }
    }

    class var foundationIconFonts: [String: String] {
        get {
            var fonts: [String: String] = [:]
            
            for family in UIFont.familyNames {
                for name in UIFont.fontNames(forFamilyName: family) {
                    guard
                        family.lowercased() == "fontcustom",
                        family.lowercased() == "fontcustom",
                        !name.isEmpty
                        else { continue }
                    fonts[family] = name
                }
            }
            
            return fonts
        }
    }
    
    static var fa_variables: [String: (String, unichar)] {
        var vars: [String: (String, unichar)] = [:]
        
        guard
            let path: String = Bundle.main.path(forResource: "_variables", ofType: "less"),
            let content: String = try? String(contentsOfFile: path, encoding: .utf8)
            else { return [:] }
        
        let contentArray: Array<String> = content.components(separatedBy: "\n")
        
        for line in contentArray {
            guard line.hasPrefix("@fa-var-") else { continue }
            guard
                let name: String = line.dropFirst(8).split(separator: ":").first?.lowercased(),
                let valuePart: String = line.dropFirst(8).split(separator: ":").last?.lowercased(),
                !name.isEmpty, name != valuePart, valuePart.hasPrefix(" \"\\"), valuePart.hasSuffix("\";")
                else { continue }
            
            let value: String = valuePart.dropFirst(3).dropLast(2).lowercased()
            guard
                !value.isEmpty, value.count == 4,
                let hexValue: UInt16 = UInt16(value.uppercased(), radix: 16)
                else { continue }
            
            let unichar: unichar = hexValue
            vars[name.iconName] = (name.replacingOccurrences(of: "_", with: "-").lowercased(), unichar)
        }
        return vars
    }

    static var ma_variables: [String: (String, unichar)] {
        
        var vars: [String: (String, unichar)] = [:]

        guard
            let path: String = Bundle.main.path(forResource: "codepoints", ofType: "txt"),
            let content: String = try? String(contentsOfFile: path, encoding: .utf8)
            else { return [:] }
        
        let contentArray: Array<String> = content.components(separatedBy: "\n")

        for line in contentArray {
            guard !line.isEmpty else { continue }
            guard
                let name: String = line.split(separator: " ").first?.lowercased(),
                let value: String = line.split(separator: " ").last?.lowercased(),
                !name.isEmpty, !value.isEmpty, name != value, value.count == 4,
                let hexValue: UInt16 = UInt16(value.uppercased(), radix: 16)
                else { continue }

            let unichar: unichar = hexValue
            vars[name.replacingOccurrences(of: "_", with: "-").iconName] = (name.replacingOccurrences(of: "_", with: "-").lowercased(), unichar)
        }
            
        return vars
    }

    static var fi_variables: [String: (String, unichar)] {
        
        var vars: [String: (String, unichar)] = [:]
        
        guard
            let path: String = Bundle.main.path(forResource: "foundation-icons", ofType: "txt"),
            let content: String = try? String(contentsOfFile: path, encoding: .utf8)
            else { return [:] }
        
        let contentArray: Array<String> = content.components(separatedBy: "\n")
        
        for line in contentArray {
            guard !line.isEmpty else { continue }
            guard
                let name: String = line.split(separator: " ").first?.lowercased(),
                let value: String = line.split(separator: " ").last?.lowercased(),
                !name.isEmpty, !value.isEmpty, name != value, value.count == 4,
                let hexValue: UInt16 = UInt16(value.uppercased(), radix: 16)
                else { continue }
            
            let unichar: unichar = hexValue
            vars[name.replacingOccurrences(of: "_", with: "-").iconName] = (name.replacingOccurrences(of: "_", with: "-").lowercased(), unichar)
        }
        
        return vars
    }
    
    class func glyphs(for font: FontType, from: [String: (String,unichar)]) -> [String: (String,unichar)] {
        
        func isSupported(_ font: UIFont, unichar: unichar) -> Bool {
            let characterSet: CharacterSet = CTFontCopyCharacterSet(font as CTFont) as CharacterSet
            return characterSet.contains(UnicodeScalar(unichar)!)
        }

        var vars: [String: (String,unichar)] = [:]
        let font: UIFont = UIFont.loadFont(font.fontName, size: 16.0, resource: font.fontResource, ext: font.fontFormat)!
        
        for entry in from {
            guard isSupported(font, unichar: entry.value.1) else { continue }
            vars[entry.key] = (entry.value.0, entry.value.1)
        }

        return vars
    }
 
    class func fontTypeCode(font: FontType, glyphs: [String: (String,unichar)] = FontGenerator.fa_variables) {
        let enclosed: Bool = font.fontNo != 0
        let vars = FontGenerator.glyphs(for: font, from: glyphs).sorted(by: { $0.key < $1.key })
        
        print("")
        print(!enclosed ? ( "public enum " + font.fontGroup.replacingOccurrences(of: " ", with: "") + ": String, IconEnum {" ) : ( "extension " + font.fontGroup.replacingOccurrences(of: " ", with: "") + " { // " + font.fontEnum ))
        print("")
        
        if ( enclosed ) {
            print("\tpublic enum " + font.fontEnum.replacingOccurrences(of: " ", with: "") + ": String, IconEnum {\n")
        }
        
        print((enclosed ? "\t\t" : "\t") + "public static var fontType: Font { return ." + font.prefix + " }")
        print("")

        for variable in vars {
            var str = enclosed ? "\t\t" : "\t"
            str += "case " + variable.key + " = \""
            str += variable.value.0 + " "
            str += "\\u{"
            str += String(variable.value.1, radix: 16, uppercase: false)
            str += "}\""
            print(str)
        }
        
        if ( enclosed ) {
            print("\t}")
        }
        
        print("}")
        
        if ( !enclosed ) {
            print("")
            print("extension " + font.fontGroup.replacingOccurrences(of: " ", with: "") + " { // " + font.fontEnum)
            print("")
            print("\tpublic static var " + font.fontEnum.replacingOccurrences(of: " ", with: "") + ": SelfType { return self.typeInstance }")
            print("}")
            
        }
        
    }
    
    class func fontListCode(fonts: ([String: (String,unichar)], [ FontType ])...) {

        var cases: [String] = []
        
        print("")
        print("public enum Font: String, FontEnum {")

        var index: Int = 0
        var instanceList: String = ""
        
        for fontType in fonts {
            let glyphs: [String: (String,unichar)] = fontType.0

            for font in fontType.1.sorted(by: { $0.fontNo < $1.fontNo }) {

                let vars = FontGenerator.glyphs(for: font, from: glyphs).sorted(by: { $0.key < $1.key })
                
                var size: CGSize = CGSize(width: 0, height: 0)
                for glyph in vars {
                    let _s: NSAttributedString = NSAttributedString(string: String(UnicodeScalar(glyph.value.1)!), attributes: [
                        .font: UIFont(name: font.fontName, size: 1.0)!
                        ])
                    size.width = max(size.width, _s.size().width)
                    size.height = max(size.height, _s.size().height)
                }

                
                instanceList += ( instanceList.isEmpty ? "" : ", " )
                instanceList += font.fontGroup
                instanceList += font.fontNo == 0 ? "" : ( "." + font.fontEnum )
                instanceList += ".self"
                
                var caseline = "\tcase " + font.prefix + " = \"" + String(index) + ","
                caseline += font.prefix + "," + font.fontGroup + ","
                caseline += font.fontEnum + "," + font.fontFamily + ","
                caseline += font.fontName + ","
                caseline += font.fontResource + ","
                caseline += font.fontFormat + ","
                caseline += String(format: "%.2f,%.2f", size.width, size.height)
                caseline += "\""

                cases.append(caseline)
                index += 1
            }
        }
        print("\tpublic static var fonts: [IconType.Type] { return [ \(instanceList) ] }")
        print("")

        for caseline in cases {
            print(caseline)
        }
        
        print("}")
    }
    
    class func loadFonts() {
        
        for font in fa_fonts.allValues as [FontType] {
            let _ = UIFont.loadFont(font.fontName, size: 0, resource: font.fontResource, ext: font.fontFormat)
        }
        
        for font in mat_fonts.allValues as [FontType] {
            let _ = UIFont.loadFont(font.fontName, size: 0, resource: font.fontResource, ext: font.fontFormat)
        }
        
        for font in fi_fonts.allValues as [FontType] {
            let _ = UIFont.loadFont(font.fontName, size: 0, resource: font.fontResource, ext: font.fontFormat)
        }
        
    }
    
    class func generateSourcecode() {
        
        for font in fa_fonts.allValues as [FontType] {
            self.fontTypeCode(font: font, glyphs: FontGenerator.fa_variables)
        }
        
        for font in mat_fonts.allValues as [FontType] {
            self.fontTypeCode(font: font, glyphs: FontGenerator.ma_variables)
        }
        
        for font in fi_fonts.allValues as [FontType] {
            self.fontTypeCode(font: font, glyphs: FontGenerator.fi_variables)
        }
        
        self.fontListCode(fonts:
                        (FontGenerator.fa_variables, fa_fonts.allValues as [FontType]),
                        (FontGenerator.ma_variables, mat_fonts.allValues as [FontType]),
                        (FontGenerator.fi_variables, fi_fonts.allValues as [FontType])
        )

    }
    
}
