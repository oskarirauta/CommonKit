//
//  TextFieldProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol TextFieldProtocol {
    var cursorMode: CursorStateEnum { get set }
    var maximumNumberOfLines: Int { get set }
    var trimText: Bool { get set }
    var selectableContent: Bool { get set }
    var maxLength: Int { get set }
    var value: String? { get set }
}

extension TextFieldProtocol where Self: UITextField {
    
    public var value: String? {
        get { return self.text }
        set { self.text = newValue }
    }
}
