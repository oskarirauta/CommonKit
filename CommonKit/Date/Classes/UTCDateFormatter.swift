//
//  UTCDateFormatter.swift
//  DateKit
//
//  Created by Oskari Rauta on 08/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class UTCDateFormatter: DateFormatter {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public init() {
        super.init()
        self.locale = Locale.appLocale
        self.timeZone = TimeZone(secondsFromGMT: 0)
    }
}
