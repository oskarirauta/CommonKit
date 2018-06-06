//
//  AppLocale.swift
//  LocaleKit
//
//  Created by Oskari Rauta on 27/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

@objc public protocol AppLocale {
    @objc optional var regionCode: String { get set }
}
