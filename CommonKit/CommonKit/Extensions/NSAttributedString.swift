//
//  NSAttributedString.swift
//  CommonKit
//
//  Created by Oskari Rauta on 20/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {

    public func numberOfLines(with width: CGFloat) -> Int {
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT)))
        let frameSetterRef : CTFramesetter = CTFramesetterCreateWithAttributedString(self as CFAttributedString)
        let frameRef: CTFrame = CTFramesetterCreateFrame(frameSetterRef, CFRangeMake(0, 0), path.cgPath, nil)
        
        guard let lines = CTFrameGetLines(frameRef) as? [CTLine] else { return 0 }
        return lines.count
    }

    public func image(definedSize: CGSize? = nil) -> UIImage? {
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
extension NSMutableAttributedString {
    
    @discardableResult public func addAttribute(_ attr: NSAttributedString.Key, value: AnyObject, range: NSRange? = nil) -> Self {
        let range = range ?? NSRange(location: 0, length: self.length)
        enumerateAttribute(attr, in: range, options: .reverse) { object, range, pointer in
            if object == nil {
                self.addAttributes([attr: value], range: range)
            }
        }
        
        return self
    }
}
