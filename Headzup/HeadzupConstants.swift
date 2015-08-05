//
//  HeadzupConstants.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/23/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

public struct LoginStatus {
    public static let NeverLoggedIn = "0"
    public static let LoggedIn = "1"
    public static let LoggedOut = "2"
}
public struct MetaDataKeys{
    public static let LoginStatus = "LoginStatus"
    public static let FirstName = "FirstName"
    public static let MembershipUserID = "MembershipUserID"
    public static let SvcUrl = "SvcUrl"
}
public struct UserActionKeys
{
    public static let UserID = "userID"
    public static let DeviceID = "deviceID"
    public static let DeviceType = "deviceType"
    public static let ActionDate = "actionDate"
    public static let OsVersion = "osVersion"
    public static let AppVersion = "appVersion"
    public static let ActionType = "actionType"
    public static let Comment = "comment"
    
}
public struct TechnicalLogKeys
{
    public static let Message = "Message"
    public static let DeviceID = "DeviceID"
    public static let Exception = "Exception"
    public static let ModuleName = "ModuleName"
    public static let EventDate = "EventDate"
    public static let AppVersion = "AppVersion"
    public static let OSVersion = "OSVersion"
    public static let LogLevel = "LogLevel"
}
