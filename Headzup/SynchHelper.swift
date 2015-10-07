//
//  SynchHelper.swift
//  Headzup
//
//  Created by Abebe Woreta on 10/1/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation
public class SynchHelper
{
    public static func SynchTailoringQuestions(dataMgr:DataManager, svcMgr:ServiceManager) {
        let membershipUserID = self.getMembershipID()
        var dict = Dictionary<String, String>()
        var responseItemsArray = [String:Dictionary<String, String>]()
        let responsesTobeSynched:[AboutMeResponse] = dataMgr.getResponsesTobeSynched()!
        var index:Int32 = 0
        if responsesTobeSynched.count > 0
        {
            for responseItem in responsesTobeSynched
            {
                print("AboutMeResponse Items: \(responseItem.questionID): \(responseItem.responseValue):\((responseItem.dateAdded))")
                
                let responseItems = ResponseItems(membershipUserId: membershipUserID, questionID: responseItem.questionID, responseValue: responseItem.responseValue, dateAdded: GeneralHelper.convertDateToString(responseItem.dateAdded))
                
                dict = self.responseItemsToDictionary(responseItems)
                responseItemsArray["ResponseItem"+String(index)] = dict
                //update index
                index++
            }
        }
        if(responseItemsArray.count > 0)
        {
            svcMgr.synchAboutMeResponse(responseItemsArray , completion: { (jsonData: JSON?)->() in
                
                if let parseJSON = jsonData {
                    let status = parseJSON["Status"]
                    if(status == 1)
                    {
                        let synchDate = NSDate()
                        dataMgr.saveMetaData("SynchResponseDate", value: GeneralHelper.convertDateToString(synchDate), isSecured: true)
                        print("About Me Response synchronized Successfully")
                    }
                }
                }
            )
        }
    }
    public static func SynchFavorites(dataMgr:DataManager, svcMgr:ServiceManager)
    {
        let membershipUserID = self.getMembershipID()
        //Synch Favorites - Strategies
        var dict = Dictionary<String, String>()
        var favItemsArray = [String:Dictionary<String, String>]()
        
        let favorites:[ContentGroup] = dataMgr.getContentGroups(0)!
        if favorites.count > 0
        {
            var index:Int32 = 0
            for favoriteItem in favorites
            {
                print("Favorite Items: \(favoriteItem.groupType.stringValue): \(favoriteItem.contentID.stringValue):\((favoriteItem.isActive.stringValue))")
                
                let favoriteItems = FavoriteItems(membershipUserID: membershipUserID, groupType: favoriteItem.groupType, contentID: favoriteItem.contentID, isActive: favoriteItem.isActive.stringValue)
                dict = self.favoriteItemsToDictionary(favoriteItems)
                favItemsArray["FavoriteItem"+String(index)] = dict
                //update index
                index++
            }
        }
        if(favItemsArray.count > 0)
        {
            svcMgr.synchFavorites(favItemsArray , completion: { (jsonData: JSON?)->() in
                if let parseJSON = jsonData {
                    let status = parseJSON["Status"]
                    if(status == 1)
                    {
                        let synchDate = NSDate()
                        dataMgr.saveMetaData("SynchDate", value: GeneralHelper.convertDateToString(synchDate), isSecured: true)
                        print("Favorite Items synchronized Successfully")
                    }
                }
                }
            )
        }

    }
    public static func SynchUserActionLogs(dataMgr:DataManager, svcMgr:ServiceManager)
    {
        let deviceId = self.getDeviceID()
        let deviceType = self.getDeviceType()
        let membershipUserID = self.getMembershipID()
        
        var dict = Dictionary<String, String>()
        var uaItemsArray = [String:Dictionary<String, String>]()
        var objectID:String?
        let userActions:[UserActionLog] = dataMgr.getUserActionLogs(0)!
        if userActions.count > 0
        {
            var index:Int32 = 0
            for userAction in userActions
            {
                let uaItems = UserActionItems(membershipUserID: membershipUserID, deviceId: deviceId, deviceType: deviceType, actionDate: GeneralHelper.convertDateToString(userAction.actionDateTime), osVersion: userAction.osVersion, appVersion: userAction.appVersion, actionType: userAction.actionType, comment:userAction.comment)
                dict = self.userActionItemsToDictionary(uaItems)
                uaItemsArray[UserActionKeys.UserActionItem+String(index)] = dict
                let lastComponent = userAction.objectID.URIRepresentation().absoluteString.lastPathComponent
                //Integer part of objectID
                objectID = lastComponent!.substringFromIndex((lastComponent!.startIndex.advancedBy(1)))
                //update index
                index++
            }
        }
        if(uaItemsArray.count > 0)
        {
            svcMgr.synchUserActions(uaItemsArray , completion: { (jsonData: JSON?)->() in
                
                if let parseJSON = jsonData {
                    let status = parseJSON["Status"]
                    if(status == 1)
                    {
                        dataMgr.saveMetaData("UserActionID", value: objectID!, isSecured: true)
                        //Delete all synched user Action logs
                        for (_, userActionLog) in userActions.enumerate()
                        {
                            dataMgr.deleteUserActionLogs(userActionLog)
                        }
                        print("User Action Logs/Items synchronized Successfully")
                    }
                }
                
            })
            
        }
    }
    public static func SynchTechnicalLogs(dataMgr:DataManager,svcMgr:ServiceManager)
    {
        //Synch TechnicalLog
        let deviceId = self.getDeviceID()
        var dict = Dictionary<String, String>()
        var techlogItemsArray = [String:Dictionary<String, String>]()
        var objectID:String?
        let technicalLogs:[TechnicalLog] = dataMgr.getTechnicalLogs(0)!
        
        if technicalLogs.count > 0
        {
            var index:Int32 = 0
            for logItems in technicalLogs
            {
                print("TechnicalLog Items: \(logItems.message): \(logItems.exception):,\(logItems.moduleName): \(logItems.eventDate), \(logItems.logLevel), \(logItems.appVersion), \(logItems.osVersion)")
                
                let techLogItems = TechnicalLogItems(message: logItems.message, deviceId: deviceId, exception: logItems.exception, moduleName: logItems.moduleName, eventDate:logItems.eventDate, appVersion: logItems.appVersion, osVersion: logItems.osVersion, logLevel: logItems.logLevel)
                dict = self.technicalLogItemsToDictionary(techLogItems)
                techlogItemsArray["TechnicalLogItem"+String(index)] = dict
                
                
                let lastComponent = logItems.objectID.URIRepresentation().absoluteString.lastPathComponent
                //Integer part of objectID
                objectID = lastComponent!.substringFromIndex((lastComponent!.startIndex.advancedBy(1)))
                //update index
                index++
            }
        }
        if(techlogItemsArray.count > 0)
        {
            svcMgr.synchTechnicalLog(techlogItemsArray , completion: { (jsonData: JSON?)->() in
                
                if let parseJSON = jsonData {
                    let status = parseJSON["Status"]
                    if(status == 1)
                    {
                        //if successful, save the last objectID to MetaData
                        dataMgr.saveMetaData("TechnicalLogID", value: objectID!, isSecured: true)
                        //Delete all synched tech logs
                        for (_, techLog) in technicalLogs.enumerate()
                        {
                            print("TechnicalLog Items: \(techLog.message): \(techLog.exception):,\(techLog.moduleName): \(techLog.eventDate), \(techLog.logLevel), \(techLog.appVersion), \(techLog.osVersion)")
                            dataMgr.deleteTechnicalLog(techLog)
                        }
                        print("Technical Logs/Items synchronized Successfully")
                    }
                }
                
                }
            )
        }
    }
    public static func userActionItemsToDictionary(uaItems: UserActionItems) -> [String:String]
    {
        return [UserActionKeys.MembershipUserID:uaItems.membershipUserId, UserActionKeys.DeviceID:uaItems.deviceId, UserActionKeys.DeviceType:uaItems.deviceType, UserActionKeys.ActionDate:uaItems.actionDate as String, UserActionKeys.OsVersion:uaItems.osVersion, UserActionKeys.AppVersion:uaItems.appVersion, UserActionKeys.ActionType:uaItems.actionType, UserActionKeys.Comment:uaItems.comment]
    }
    public static func technicalLogItemsToDictionary(tLogItems: TechnicalLogItems) -> [String:String]
    {
        return [TechnicalLogKeys.Message:tLogItems.message, TechnicalLogKeys.DeviceID:tLogItems.deviceId, TechnicalLogKeys.Exception:tLogItems.exception, TechnicalLogKeys.ModuleName:tLogItems.moduleName, TechnicalLogKeys.EventDate:tLogItems.eventDate as String, TechnicalLogKeys.AppVersion:tLogItems.appVersion, TechnicalLogKeys.OSVersion:tLogItems.osVersion, TechnicalLogKeys.LogLevel:tLogItems.logLevel]
    }
    public static func favoriteItemsToDictionary(favoriteItems: FavoriteItems) -> [String:String]
    {
        return [FavoriteKeys.MembershipUserID:favoriteItems.membershipUserId, FavoriteKeys.GroupType:favoriteItems.groupType.stringValue, FavoriteKeys.ContentID:favoriteItems.contentID.stringValue, FavoriteKeys.IsActive:favoriteItems.isActive]
    }
    public static func responseItemsToDictionary(responseItems: ResponseItems) -> [String:String]
    {
        return [AboutMeResponseKeys.MembershipUserID:responseItems.membershipUserId, AboutMeResponseKeys.QuestionID:responseItems.questionID, AboutMeResponseKeys.ResponseValue:responseItems.responseValue, AboutMeResponseKeys.DateAdded:responseItems.dateAdded as String]
    }
    public static func getMembershipID() -> String
    {
        let uInfo = AppContext.getUserInfo()
        return uInfo.membershipUserID

    }
    public static func getDeviceID() -> String
    {
        let uInfo = AppContext.getUserInfo()
        return uInfo.deviceId
        
    }
    public static func getDeviceType() -> String
    {
        let uInfo = AppContext.getUserInfo()
        return uInfo.deviceType
        
    }
}
