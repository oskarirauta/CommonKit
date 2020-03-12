//
//  DateFormatter.swift
//  DateKit
//
//  Created by Oskari Rauta on 08/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension DateFormatter {
    
    convenience init(mode: UIDatePicker.Mode) {
        self.init()
        self.locale = Locale.appLocale
        self.dateStyle = (( mode == .date ) || ( mode == .dateAndTime )) ? .short : .none
        self.timeStyle = (( mode == .time ) || ( mode == .dateAndTime )) ? .short : .none
    }
    
    convenience init(dateFormat: String) {
        self.init()
        self.locale = Locale.appLocale
        self.dateFormat = dateFormat
    }
    
    convenience init(posixDateFormat: String) {
        self.init()
        self.locale = Locale(identifier: "en_US_POSIX")
        self.dateFormat = posixDateFormat
    }
    
    convenience init(localizedDateFormat: String, options: Int = 0) {
        self.init()
        self.locale = Locale.appLocale
        self.dateFormat = DateFormatter.dateFormat(fromTemplate: localizedDateFormat, options: options, locale: Locale.appLocale)
    }
}
