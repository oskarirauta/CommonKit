//
//  UUIDExtension.swift
//  CommonKit
//
//  Created by Oskari Rauta on 08/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol UUIDExtension {
    var uuid: String? { get set }
}

extension UITableViewCell: UUIDExtension {}
