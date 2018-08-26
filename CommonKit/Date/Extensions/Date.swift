//
//  Date.swift
//  DateKit
//
//  Created by Oskari Rauta on 08/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension Date {
    
    public static var `nil`: Date {
        get { return Date(timeIntervalSinceReferenceDate: 0) }
    }
    
    public init(year: Int, month: Int, day: Int) {
        self.init()
        self = UTCDateFormatter(posixDateFormat: "yyyy-MM-dd").date(from: String(year) + "-" + String(month) + "-" + String(day))!
    }
    
    public init(year: Int, month: Int, day: Int, hour: Int, minute: Int) {
        self.init(year: year, month: month, day: day)
        self = self.addingTimeInterval(TimeInterval(60 * ( minute + ( 60 * hour ))))
    }
    
    public init(hour: Int, minute: Int) {
        self = Date.nil
        self = self.addingTimeInterval(TimeInterval(60 * ( minute + ( 60 * hour ))))
    }
    
    public var second: Int {
        get { return Int(UTCDateFormatter(posixDateFormat: "ss").string(from: self)) ?? -1 }
    }
    
    public var minute: Int {
        get { return Int(UTCDateFormatter(posixDateFormat: "mm").string(from: self)) ?? -1 }
    }
    
    public var hour: Int {
        get { return Int(UTCDateFormatter(posixDateFormat: "HH").string(from: self)) ?? -1 }
    }
    
    public var day: Int {
        get { return Int(UTCDateFormatter(posixDateFormat: "dd").string(from: self)) ?? -1 }
    }
    
    public var month: Int {
        get { return Int(UTCDateFormatter(posixDateFormat: "MM").string(from: self)) ?? -1 }
    }
    
    public var year: Int {
        get { return Int(UTCDateFormatter(posixDateFormat: "yyyy").string(from: self)) ?? -1 }
    }
    
    public var weekday: Int {
        get { return Int(UTCDateFormatter(posixDateFormat: "ee").string(from: self)) ?? -1 }
    }
    
    public var weekOfMonth: Int {
        get { return Int(UTCDateFormatter(posixDateFormat: "W").string(from: self)) ?? -1 }
    }
    
    public var weekOfYear: Int {
        get { return Int(UTCDateFormatter(posixDateFormat: "w").string(from: self)) ?? -1 }
    }
    
    public var dayName: String {
        get { return UTCDateFormatter(localizedDateFormat: "cccc").string(from: self) }
    }
    
    public var shortDayName: String {
        get { return UTCDateFormatter(localizedDateFormat: "EEE").string(from: self) }
    }
    
    public var isWeekend: Bool {
        return [1,7].contains(self.weekday) ? true : false
    }
    
    public var isSunday: Bool {
        return self.weekday == 1 ? true : false
    }
    
    public var isSaturday: Bool {
        return self.weekday == 7 ? true : false
    }
    
    public var monthName: String {
        get { return UTCDateFormatter(localizedDateFormat: "LLLL").string(from: self) }
    }
    
    public var shortMonthName: String {
        get { return UTCDateFormatter(localizedDateFormat: "LLL").string(from: self) }
    }
    
    public var timeString: String {
        get { return UTCDateFormatter(mode: .time).string(from: self) }
    }
    
    public var timeStringWithSeconds: String {
        get { return UTCDateFormatter(localizedDateFormat: "HHmmss").string(from: self) }
    }
    
    public var dateString: String {
        get { return UTCDateFormatter(mode: .date).string(from: self) }
    }
    
    public var dateTimeString: String {
        get { return UTCDateFormatter(mode: .dateAndTime).string(from: self) }
    }
    
    public var dateStringWithoutDate: String {
        get { return UTCDateFormatter(localizedDateFormat: "y LLLL").string(from: self) }
    }
    
    public var dateStringWithoutYear: String {
        get {
            var retStr: String = UTCDateFormatter(localizedDateFormat: "Md").string(from: self)
            let set = CharacterSet(charactersIn: "0123456789")
            
            while (( retStr.count > 0 ) && ( !set.contains(retStr.unicodeScalars.first ?? "0"))) {
                retStr = retStr.substring(from: 1)
            }
            
            while (( retStr.count > 0 ) && ( !set.contains(retStr.unicodeScalars.last ?? "0" ))) {
                retStr = retStr.substring(to: 1)
            }
            return retStr
        }
    }
    
    public var uuid_string: String {
        get { return "DateObj_" + String(self.year) + "_" + String(self.month) + "_" + String(self.day) }
    }
    
    public var zero: Date {
        mutating get {
            self = Date(timeIntervalSinceReferenceDate : 0)
            return self
        }
    }
    
    public var zeroHour: Date {
        get {
            let retDate: Date = Date(timeInterval: 0, since: UTCDateFormatter(posixDateFormat: "yyyy-MM-dd").date(from: String(self.year) + "-" + String(self.month) + "-" + String(self.day))!)
            return retDate.timeIntervalSinceReferenceDate < 0 ? Date.nil : retDate
        }
    }
    
    public var zeroDate: Date {
        get { return self.isZero ? self : Date(hour: self.hour, minute: self.minute).addingTimeInterval(86400 * 2) }
    }
    
    public var zeroMonth: Date {
        get {
            let retDate: Date = Date(timeInterval: 0, since: UTCDateFormatter(posixDateFormat: "yyyy-MM-dd").date(from: String(self.year) + "-" + String(self.month) + "-1")!)
            return retDate.timeIntervalSinceReferenceDate < 0 ? Date.nil : retDate.zeroHour
        }
    }
    
    public func dateBeforeDays(_ days: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(-86400 * days))
    }
    
    public var yesterday: Date {
        get { return self.addingTimeInterval(-86400) }
    }
    
    public var tomorrow: Date {
        get { return self.addingTimeInterval(86400) }
    }
    
    public var farFuture: Date {
        get { return self.addingTimeInterval(86400 * 500) }
    }
    
    public var monthsLast: Date {
        get { return self.month < 12 ? Date(timeInterval: 0, since: UTCDateFormatter(posixDateFormat: "yyyy-MM-dd").date(from: String(self.year) + "-" + String(Int(self.month + 1)) + "-1")!.yesterday).zeroHour : Date(timeInterval: 0, since: UTCDateFormatter(posixDateFormat: "yyyy-MM-dd").date(from: String(Int(self.year + 1)) + "-1-1")!.yesterday).zeroHour }
    }
    
    public var yearsLast: Date {
        get { return Date(timeInterval: 0, since:  UTCDateFormatter(posixDateFormat: "yyyy-MM-dd").date(from: String(Int(self.year + 1)) + "-1-1")!.yesterday.zeroHour) }
    }
    
    public var isNil: Bool {
        get { return self.timeIntervalSinceReferenceDate == 0 ? true : false }
    }
    
    public var isEmpty: Bool {
        get { return self.isNil }
    }
    
    public var isZero: Bool {
        get { return self.isNil }
    }
    
    public func withMinuteInterval(_ interval: Int) -> Date {
        if (( interval != 15 ) && ( interval != 30 )) { return self }
        let minutes = self.minute
        let minutesRounded = ( minutes / interval ) * interval
        return Date(timeInterval: TimeInterval(60.0 * Double( minutesRounded - minutes )), since: self)
    }
    
    public func datesBetween(_ date: Date) -> [Date] {
        
        if ( self == date ) { return [ self.zeroHour ] }
        
        var current: Date = (self < date ? self : date).zeroHour
        let endDate: Date = ( self < date ? date : self ).zeroHour
        var retArray: [Date] = [ current ]
        
        while (( current != endDate ) && ( retArray.count < 32 )) {
            var tmpDate: Date = current.addingTimeInterval(86400)
            while ( tmpDate.zeroHour == current ) { tmpDate = tmpDate.addingTimeInterval(100) }
            current = tmpDate.zeroHour
            retArray.append(current)
        }
        
        return retArray
    }
    
    public func hoursBetween(_ date: Date) -> Decimal {
        
        let date1: Date = Date(year: 2000, month: 1, day: 1, hour: self.hour, minute: self.minute)
        var date2: Date = Date(year: 2000, month: 1, day: 1, hour: date.hour, minute: date.minute)
        
        if ( date2.timeIntervalSince1970 <= date1.timeIntervalSince1970 ) { date2 = Date(year: 2000, month: 1, day: 2, hour: date.hour, minute: date.minute) }
        
        var between: Decimal = Decimal(date2.timeIntervalSince(date1))
        
        let hours: Decimal = Decimal((between / 3600).floor().intValue)
        if hours > 0 { between -= hours * 3600.0 }

        let minutes: Decimal = Decimal((between / 60.0).floor().intValue)
        if ( minutes > 0 ) { between -= minutes * 60.0 }

        switch minutes {
        case 15: return hours + 0.25
        case 30: return hours + 0.50
        case 45: return hours + 0.75
        default: return hours
        }
    }
    
    public func convertToUtc(from: TimeZone) -> Date {
        
        if ( self.isZero ) {
            return self
        }
        
        let tf: DateFormatter = DateFormatter(posixDateFormat: "yyyy-MM-dd-HH-mm")
        tf.timeZone = from
        let timeStr: String = tf.string(from: self)
        
        return Date(
            year: Int(timeStr.components(separatedBy: "-")[0])!,
            month: Int(timeStr.components(separatedBy: "-")[1])!,
            day: Int(timeStr.components(separatedBy: "-")[2])!,
            hour: Int(timeStr.components(separatedBy: "-")[3])!,
            minute: Int(timeStr.components(separatedBy: "-")[4])!)
    }
    
    public func isEqualDate(_ date: Date) -> Bool {
        return self.day == date.day && self.month == date.month && self.year == date.year ? true : false
    }
}
