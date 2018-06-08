//
//  CellHandlerProtocol.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol UICellDelegateSelectableBase {
    @objc optional func internalSetSelected(_ selected: Bool, animated: Bool)
}

public protocol UICellDelegateSelectable: UICellDelegateSelectableBase {
    var handler: CellHandler { get set }
    func returnValues() -> CellReturn
}

extension UICellDelegateSelectable {
    
    public func returnValues() -> CellReturn {
        return CellReturn(cell: self as! UITableViewCell)
    }
}
