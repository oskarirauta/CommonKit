//
//  CurrencyFieldDelegate.swift
//  CurrencyKit
//
//  Created by Oskari Rauta on 23/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public protocol CurrencyFieldDelegate {
   
    var value: Money? { get set }
    var allowSignChange: Bool { get set }
    var locale: Locale { get set }
    var clearButtonMode: UITextField.ViewMode { get set }
    
    func pressNumber(number: Int)
    func pressBackspace()
    func pressSignToggle()
}
