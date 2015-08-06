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
        
        
        //TO BE REMOVED LATER ON - THIS IS TEMPORARY PLACE
        
        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        // Do any additional setup after loading the view.
        serviceMgr = ServiceManager(objContext: manObjContext)
        
        var uInfo = AppContext.getUserInfo()
        var deviceId = uInfo.deviceId
        var deviceType = uInfo.deviceType
        var userId = uInfo.userId
        
        var dict = Dictionary<String, String>()
        var uaItemsArray = [String:Dictionary<String, String>]()
        var objectID:String?
        var gHelpers = GeneralHelper()
        if let userActions = dataMgr?.getUserActionLogs(0)
        {
            var index:Int32 = 0
            for userAction in userActions
            {
                
                var uaItems = UserActionItems(userId: userId, deviceId: deviceId, deviceType: deviceType, actionDate: gHelpers.convertDateToString(userAction.actionDateTime), osVersion: userAction.osVersion, appVersion: userAction.appVersion, actionType: userAction.actionType, comment:userAction.comment)
                dict = gHelpers.userActionItemsToDictionary(uaItems)
                uaItemsArray[UserActionKeys.UserActionItem+String(index)] = dict
                
                
                var lastComponent = userAction.objectID.URIRepresentation().absoluteString!.lastPathComponent
                //Integer part of objectID
                objectID = lastComponent.substringFromIndex(advance(lastComponent.startIndex, 1))
                //update index
                index++
            }
        }
        if NSJSONSerialization.isValidJSONObject(uaItemsArray)
        {
            println("UserActionItems is valid JSON")
        
            var theURL:String =  AppContext.svcUrl + "TrackUserAction"
            
            if(uaItemsArray.count > 0)
            {
                serviceMgr?.synchUserActions(uaItemsArray , url: theURL, postCompleted: { (jsonData: NSDictionary?)->() in
                    
                    if let parseJSON = jsonData {
                        var status = parseJSON["Status"] as? Int
                        if(status == 1)
                        {
                            self.dataMgr?.saveMetaData("UserActionID", value: objectID!, isSecured: true)
                            println("User Action Logs/Items synchronized Successfully")
                        }
                    }
                    
                })
                
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Logout(sender: UIButton) {
        // update login status
        dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedOut, isSecured: true)
        AppContext.loginStatus = LoginStatus.LoggedOut
        
        //TO BE REMOVED
        //self.dataMgr?.saveUserActionLog(UserActions.Logout, actionDateTime: NSDate(), contentID: "", comment: "Logout", isSynched: false)
        
        self.loadViewController("PinView")
     }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
