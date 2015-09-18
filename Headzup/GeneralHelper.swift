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
        return [UserActionKeys.MembershipUserID:uaItems.membershipUserId, UserActionKeys.DeviceID:uaItems.deviceId, UserActionKeys.DeviceType:uaItems.deviceType, UserActionKeys.ActionDate:uaItems.actionDate as String, UserActionKeys.OsVersion:uaItems.osVersion, UserActionKeys.AppVersion:uaItems.appVersion, UserActionKeys.ActionType:uaItems.actionType, UserActionKeys.Comment:uaItems.comment]
    }
    func technicalLogItemsToDictionary(tLogItems: TechnicalLogItems) -> [String:String]
    {
        return [TechnicalLogKeys.Message:tLogItems.message, TechnicalLogKeys.DeviceID:tLogItems.deviceId, TechnicalLogKeys.Exception:tLogItems.exception, TechnicalLogKeys.ModuleName:tLogItems.moduleName, TechnicalLogKeys.EventDate:tLogItems.eventDate as String, TechnicalLogKeys.AppVersion:tLogItems.appVersion, TechnicalLogKeys.OSVersion:tLogItems.osVersion, TechnicalLogKeys.LogLevel:tLogItems.logLevel]
    }
    func favoriteItemsToDictionary(favoriteItems: FavoriteItems) -> [String:String]
    {
        return [FavoriteKeys.MembershipUserID:favoriteItems.membershipUserId, FavoriteKeys.GroupType:favoriteItems.groupType.stringValue, FavoriteKeys.ContentID:favoriteItems.contentID.stringValue, FavoriteKeys.IsActive:favoriteItems.isActive]
    }
    func responseItemsToDictionary(responseItems: ResponseItems) -> [String:String]
    {
        return [AboutMeResponseKeys.MembershipUserID:responseItems.membershipUserId, AboutMeResponseKeys.QuestionID:responseItems.questionID, AboutMeResponseKeys.ResponseValue:responseItems.responseValue, AboutMeResponseKeys.DateAdded:responseItems.dateAdded as String]
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
