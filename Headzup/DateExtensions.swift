//
//  DateExtensions.swift
//  Headzup
//
//  Created by Abebe Woreta on 8/11/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

extension NSDate
{
    func isGreaterThanDate(dateToCompare:NSDate)->Bool
    {
        var isGreater = false
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
        {
            isGreater = true
        }
        return isGreater
    }
    func isLessThanDate(dateToCompare:NSDate) -> Bool
    {
        var isLess = false
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
        {
            isLess = true
        }
        return isLess
    }
    func isEqualtoDate(dateToCompare : NSDate) -> Bool
    {
        var isEqualTo = false

        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame
        {
            isEqualTo = true
        }
        return isEqualTo
    }

    func addDays(daysToAdd:Int)->NSDate
    {
        let secondsInDays:NSTimeInterval = Double(daysToAdd)*60*60*24
        let dateWithDaysAdded:NSDate = self.dateByAddingTimeInterval(secondsInDays)
        return dateWithDaysAdded
    }
    func addHours(hoursToAdd:Int)->NSDate
    {
        let secondsInHours:NSTimeInterval = Double(hoursToAdd)*60*60
        let dateWithHoursAdded:NSDate = self.dateByAddingTimeInterval(secondsInHours)
        return dateWithHoursAdded
    }
    func beginningOfDay() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day], fromDate: self)
        return calendar.dateFromComponents(components)!
    }
}

