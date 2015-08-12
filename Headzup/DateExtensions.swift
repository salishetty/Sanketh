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
    /*func isEqualToDate(dateToCompare:NSDate) -> Bool
    {
        var isEqualTo = false
        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame
        {
            isEqualTo = true
        }
        return isEqualTo
    }*/
    func addDays(daysToAdd:Int)->NSDate
    {
        var secondsInDays:NSTimeInterval = Double(daysToAdd)*60*60*24
        var dateWithDaysAdded:NSDate = self.dateByAddingTimeInterval(secondsInDays)
        return dateWithDaysAdded
    }
    func addHours(hoursToAdd:Int)->NSDate
    {
        var secondsInHours:NSTimeInterval = Double(hoursToAdd)*60*60
        var dateWithHoursAdded:NSDate = self.dateByAddingTimeInterval(secondsInHours)
        return dateWithHoursAdded
    }
}

