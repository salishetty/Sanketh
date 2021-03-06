//
//  ProfileViewController.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/30/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    //Add a reference to DataManger
    var dataMgr: DataManager?
    var serviceMgr:ServiceManager?
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func StartTracker(sender: UIButton) {
//        
//        let date = NSDate()
//        NotificationHelper.EnableTrackerNotifcation(date);
//        
//    }
//    @IBAction func StopTracker(sender: UIButton) {
//       
//        NotificationHelper.DisableNotification(NotificationConstants.TrackerName)
//    }
//
//    @IBAction func StartGoal(sender: AnyObject) {
//        let date = NSDate()
//        NotificationHelper.EnableGoalNotifcation(date, goalName: "Goal 1");
//    }
//    
//    
//    @IBAction func ChangeGoal(sender: AnyObject) {
//        NotificationHelper.UpdateGoalNotification(NotificationConstants.GoalName, goalName: "Goal 2")
//    }
//    
//    @IBAction func StopGoal(sender: AnyObject) {
//        
//         NotificationHelper.DisableNotification(NotificationConstants.GoalName)
//    }
//    
//    
//    
//    
//    
//    @IBAction func Logout(sender: UIButton) {
////        // update login status
////        dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedOut, isSecured: true)
////        AppContext.loginStatus = LoginStatus.LoggedOut
////        
////        //TO BE REMOVED
////        self.dataMgr?.saveUserActionLog(UserActions.Logout, actionDateTime: NSDate(), contentID: "", comment: "Logout", isSynched: false)
////        
////        self.loadViewController("PinView")
//     }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//    
//    var index=0
//    @IBAction func AddTechLogs(sender: UIButton) {
////        var gHelpers = GeneralHelper()
////        index = index+1
////        dataMgr?.saveTechnicalLog("Message\(index)", exception: "Exception\(index)", moduleName: "Login", eventDate: gHelpers.convertDateToString(NSDate()), appVersion: "1.0", osversion: "8.3", logLevel: "Error", isSynched: false)
//    }
//    
//   //TEMPORARY - TO BE MOVED LATER
//    @IBAction func SynchTechLogs(sender: UIButton) {
//        //Synch TechnicalLog
//        var uInfo = AppContext.getUserInfo()
//        var deviceId = uInfo.deviceId
//        var gHelper = GeneralHelper()
//        var dict = Dictionary<String, String>()
//        var tlItemsArray = [String:Dictionary<String, String>]()
//        var objectID:String?
//        let technicalLogs:[TechnicalLog] = dataMgr!.getTechnicalLogs(0)!
//        
//        if technicalLogs.count > 0
//        {
//            var index:Int32 = 0
//            for logItems in technicalLogs
//            {
//                println("TechnicalLog Items: \(logItems.message): \(logItems.exception):,\(logItems.moduleName): \(logItems.eventDate), \(logItems.logLevel), \(logItems.appVersion), \(logItems.osVersion)")
//                
//                var tLogItems = TechnicalLogItems(message: logItems.message, deviceId: deviceId, exception: logItems.exception, moduleName: logItems.moduleName, eventDate:logItems.eventDate, appVersion: logItems.appVersion, osVersion: logItems.osVersion, logLevel: logItems.logLevel)
//                dict = gHelper.technicalLogItemsToDictionary(tLogItems)
//                tlItemsArray["TechnicalLogItem"+String(index)] = dict
//                
//                
//                var lastComponent = logItems.objectID.URIRepresentation().absoluteString!.lastPathComponent
//                //Integer part of objectID
//                objectID = lastComponent.substringFromIndex(advance(lastComponent.startIndex, 1))
//                //update index
//                index++
//            }
//        }
//        
//        var theURL:String =  AppContext.svcUrl + "SynchTechnicalLogItems"
//        
//        if(tlItemsArray.count > 0)
//        {
//            serviceMgr?.synchTechnicalLog(tlItemsArray , url: theURL, postCompleted: { (jsonData: NSDictionary?)->() in
//                
//                if let parseJSON = jsonData {
//                    var status = parseJSON["Status"] as? Int
//                    if(status == 1)
//                    {
//                        //if successful, save the last objectID to MetaData
//                        self.dataMgr?.saveMetaData("TechnicalLogID", value: objectID!, isSecured: true)
//                        //Delete all synched tech logs
//                        for (index, techLog) in enumerate(technicalLogs)
//                        {
//                            println("TechnicalLog Items: \(techLog.message): \(techLog.exception):,\(techLog.moduleName): \(techLog.eventDate), \(techLog.logLevel), \(techLog.appVersion), \(techLog.osVersion)")
//                            self.dataMgr?.deleteTechnicalLog(techLog)
//                        }
//                        println("Technical Logs/Items synchronized Successfully")
//                    }
//                }
//                
//                }
//            )
//            
//            // Do any additional setup after loading the view.
//        }
//
//    }
//    
//    @IBAction func SynchUserActionLogs(sender: UIButton) {
//        //TO BE REMOVED LATER ON - THIS IS TEMPORARY PLACE
//        
//        var uInfo = AppContext.getUserInfo()
//        var deviceId = uInfo.deviceId
//        var deviceType = uInfo.deviceType
//        var membershipUserID = uInfo.membershipUserID
//        
//        var dict = Dictionary<String, String>()
//        var uaItemsArray = [String:Dictionary<String, String>]()
//        var objectID:String?
//        var gHelpers = GeneralHelper()
//        let userActions:[UserActionLog] = dataMgr!.getUserActionLogs(0)!
//        if userActions.count > 0
//        {
//            var index:Int32 = 0
//            for userAction in userActions
//            {
//                
//                var uaItems = UserActionItems(membershipUserID: membershipUserID, deviceId: deviceId, deviceType: deviceType, actionDate: gHelpers.convertDateToString(userAction.actionDateTime), osVersion: userAction.osVersion, appVersion: userAction.appVersion, actionType: userAction.actionType, comment:userAction.comment)
//                dict = gHelpers.userActionItemsToDictionary(uaItems)
//                uaItemsArray[UserActionKeys.UserActionItem+String(index)] = dict
//                
//                
//                var lastComponent = userAction.objectID.URIRepresentation().absoluteString!.lastPathComponent
//                //Integer part of objectID
//                objectID = lastComponent.substringFromIndex(advance(lastComponent.startIndex, 1))
//                //update index
//                index++
//            }
//        }
//        if NSJSONSerialization.isValidJSONObject(uaItemsArray)
//        {
//            println("UserActionItems is valid JSON")
//            
//            var theURL:String =  AppContext.svcUrl + "TrackUserAction"
//            
//            if(uaItemsArray.count > 0)
//            {
//                serviceMgr?.synchUserActions(uaItemsArray , url: theURL, postCompleted: { (jsonData: NSDictionary?)->() in
//                    
//                    if let parseJSON = jsonData {
//                        var status = parseJSON["Status"] as? Int
//                        if(status == 1)
//                        {
//                            self.dataMgr?.saveMetaData("UserActionID", value: objectID!, isSecured: true)
//                            //Delete all synched user Action logs
//                            for (index, userActionLog) in enumerate(userActions)
//                            {
//                                self.dataMgr?.deleteUserActionLogs(userActionLog)
//                            }
//                            
//                            println("User Action Logs/Items synchronized Successfully")
//                        }
//                    }
//                    
//                })
//                
//            }
//        }
//
//    }
//    
//    
//    @IBAction func SynchFavorites(sender: UIButton) {
//        var uInfo = AppContext.getUserInfo()
//        var membershipUserID = uInfo.membershipUserID
//        //Synch Favorites - Strategies
//        var dict = Dictionary<String, String>()
//        var favItemsArray = [String:Dictionary<String, String>]()
//        var objectID:String?
//        var gHelper = GeneralHelper()
//        let favorites:[ContentGroup] = dataMgr!.getContentGroups(0)!
//        if favorites.count > 0
//        {
//            var index:Int32 = 0
//            for favoriteItem in favorites
//            {
//                println("Favorite Items: \(favoriteItem.groupType.stringValue): \(favoriteItem.contentID.stringValue):\((favoriteItem.isActive.stringValue))")
//                
//                var favoriteItems = FavoriteItems(membershipUserID: membershipUserID, groupType: favoriteItem.groupType, contentID: favoriteItem.contentID, isActive: favoriteItem.isActive.stringValue)
//                dict = gHelper.favoriteItemsToDictionary(favoriteItems)
//                favItemsArray["FavoriteItem"+String(index)] = dict
//                //update index
//                index++
//            }
//        }
//        var theURL:String =  AppContext.svcUrl + "SynchFavoriteItems"
//        
//        if(favItemsArray.count > 0)
//        {
//            serviceMgr?.synchFavorites(favItemsArray , url: theURL, postCompleted: { (jsonData: NSDictionary?)->() in
//                
//                if let parseJSON = jsonData {
//                    var status = parseJSON["Status"] as? Int
//                    if(status == 1)
//                    {
//                        var synchDate = NSDate()
//                        //if successful, save the last objectID to NSUserDefaults
//                        //NSUserDefaults.standardUserDefaults().setObject(objectID, forKey: "ObjectID")
//                        self.dataMgr?.saveMetaData("SynchDate", value: gHelper.convertDateToString(synchDate), isSecured: true)
//                        println("Favorite Items synchronized Successfully")
//                    }
//                }
//                
//                }
//            )
//            // Do any additional setup after loading the view.
//        }
//
//    }
}
