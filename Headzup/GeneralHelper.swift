//
//  GeneralHelper.swift
//  Headzup
//
//  Created by Abebe Woreta on 8/5/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

public class GeneralHelper
{
    public static func convertDateToString(date:NSDate)->String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.stringFromDate(date)
        return dateString
    }
    public static func convertStringToDate(dateString:String)->NSDate
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.dateFromString(dateString)
        return date!
    }
    public func getPListProperty(plistProperty: String) -> String {
        
        if let pListPropertyValue = NSBundle.mainBundle().infoDictionary?[plistProperty] as? String {
            return pListPropertyValue
        }
        return "no Plist Property info"
    }
    public static func convertStringToNSNumber(stringVal:String) ->NSNumber
    {
        return NSNumberFormatter().numberFromString(stringVal)!
    }
}
