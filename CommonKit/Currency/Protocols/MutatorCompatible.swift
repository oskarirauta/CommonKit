//
//  MutatorCompatible.swift
//  CommonKit
//
//  Created by Oskari Rauta on 07/09/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol AbstractMutatorCompatible {
    
    var name: String? { get set }
    var percentage: Decimal { get set }
}

public protocol MutatorCompatible: AbstractMutatorCompatible { }
