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
    init ()
    {
    }
    func userActionItemsToDictionary(uaItems: UserActionItems) -> [String:String]
    {
        return [UserActionKeys.UserID:uaItems.userId, UserActionKeys.DeviceID:uaItems.deviceId, UserActionKeys.DeviceType:uaItems.deviceType, UserActionKeys.ActionDate:uaItems.actionDate as String, UserActionKeys.OsVersion:uaItems.osVersion, UserActionKeys.AppVersion:uaItems.appVersion, UserActionKeys.ActionType:uaItems.actionType, UserActionKeys.Comment:uaItems.comment]
    }
    func technicalLogItemsToDictionary(tLogItems: TechnicalLogItems) -> [String:String]
    {
        return [TechnicalLogKeys.Message:tLogItems.message, TechnicalLogKeys.DeviceID:tLogItems.deviceId, TechnicalLogKeys.Exception:tLogItems.exception, TechnicalLogKeys.ModuleName:tLogItems.moduleName, TechnicalLogKeys.EventDate:tLogItems.eventDate as String, TechnicalLogKeys.AppVersion:tLogItems.appVersion, TechnicalLogKeys.OSVersion:tLogItems.osVersion, TechnicalLogKeys.LogLevel:tLogItems.logLevel]
    }
    func convertDateToString(date:NSDate)->String
    {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var dateString = dateFormatter.stringFromDate(date)
        return dateString
    }
    func convertStringToDate(dateString:String)->NSDate
    {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var date = dateFormatter.dateFromString(dateString)
        return date!
    }
    public func getPListProperty(plistProperty: String) -> String {
        
        if let pListPropertyValue = NSBundle.mainBundle().infoDictionary?[plistProperty] as? String {
            return pListPropertyValue
        }
        return "no Plist Property info"
    }
}
