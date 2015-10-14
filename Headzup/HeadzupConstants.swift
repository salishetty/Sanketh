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
public struct UserActions {
    public static let Login = "1"
    public static let Logout = "2"
    public static let TrackData = "3"
    public static let ViewHistory = "4"
    public static let ViewStrategy = "5"
}
public struct UserActionKeys
{
    public static let MembershipUserID = "membershipUserID"
    public static let DeviceID = "deviceID"
    public static let DeviceType = "deviceType"
    public static let ActionDate = "actionDate"
    public static let OsVersion = "osVersion"
    public static let AppVersion = "appVersion"
    public static let ActionType = "actionType"
    public static let Comment = "comment"
    public static let UserActionItem = "userActionItem"
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
public struct FavoriteKeys
{
    public static let MembershipUserID = "MembershipUserID"
    public static let GroupType = "GroupType"
    public static let ContentID = "ContentID"
    public static let IsActive = "IsActive"
}
public struct AboutMeResponseKeys
{
    public static let MembershipUserID = "MembershipUserID"
    public static let QuestionID = "QuestionID"
    public static let ResponseValue = "ResponseValue"
    public static let DateAdded = "LastModifiedDate"
}
public struct TrackerResponseKeys
{
    public static let TrackDate = "TrackDate"
    public static let hadHeadache = "HadHeadache"
    public static let painLevel = "PainLevel"
    public static let affectSleep = "AffectSleep"
    public static let affectActivity = "AffectActivity"
    public static let painReasons = "PainReasons"
    public static let helpfulContent = "HelpfulContent"

}
public struct AboutMeResponseQuestions
{
    public static let AMQText_1 = "Relaxation, Meditation, Deep Breathing, etc"
    public static let AMQText_2 = "Managing your time better"
    public static let AMQText_3 = "Eating healthy"
    public static let AMQText_4 = "Sleeping better"
    public static let AMQText_5 = "Reducing Caffeine intake"
    public static let AMQText_6 = "Drinking more water"
    public static let AMQText_7 = "Getting more physical activity"
    public static let AMQText_8 = "Tips for talking to teachers, parents or friends about headache pain"
    public static let AMQText_9 = "Figuring out if your headaches follow a pattern"
    public static let AMQText_10 = "Distracting yourself when you have a headache"
    
    
}
public struct AboutMeResponseQuestionCode
{
    public static let AMQ_1 = "AMQ_1"
    public static let AMQ_2 = "AMQ_2"
    public static let AMQ_3 = "AMQ_3"
    public static let AMQ_4 = "AMQ_4"
    public static let AMQ_5 = "AMQ_5"
    public static let AMQ_6 = "AMQ_6"
    public static let AMQ_7 = "AMQ_7"
    public static let AMQ_8 = "AMQ_8"
    public static let AMQ_9 = "AMQ_9"
    public static let AMQ_10 = "AMQ_10"
    public static let AMQ_11 = "AMQ_11"
    
}
public struct GroupType
{
    public static let Favorite = "1"
    public static let OMG = "2"
}
public struct ContentKeys
{
    public static let CategoryID = "CategoryID"
    public static let CategoryName = "CategoryName"
    public static let Contents = "Contents"
    public static let ContentId = "ContentId"
    public static let ContentName = "ContentName"
    public static let ContentValue = "ContentValue"
    public static let Description = "Description"
    public static let ContentProperties = "ContentProperties"
    public static let PropertyID = "PropertyID"
    public static let PropertyValue = "PropertyValue"
    public static let Intervention = "Intervention"
    public static let ContentID = "ContentID"
    
}
public struct ICMSProperty
{
    public static let HeadzupContentType = "21"
    public static let HeadzupImagePath = "22"
    public static let HeadzupAudioPath = "23"
    
}