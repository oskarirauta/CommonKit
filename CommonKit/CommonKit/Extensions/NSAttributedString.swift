//
//  NSAttributedString.swift
//  CommonKit
//
//  Created by Oskari Rauta on 20/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

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

}
