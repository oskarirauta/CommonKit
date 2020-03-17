//
//  SelectableCell.swift
//  CommonKit
//
//  Created by Oskari Rauta on 15.03.20.
//  Copyright © 2020 Oskari Rauta. All rights reserved.
//

import Foundation

@objc public protocol SelectableCellObjc {
    
    @objc optional func internalSetSelected(_ selected: Bool, animated: Bool)
}


public protocol SelectableCellProperties {
    
    var handler: CellHandler { get set }
}

public protocol SelectableCellMethods {
    
    func returnValues() -> CellReturn
}

public protocol SelectableCell: SelectableCellObjc, SelectableCellProperties, SelectableCellMethods { }
