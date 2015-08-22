//
//  LogInHelper.swift
//  Headzup
//  All login related code should be moved here
//  Created by Sandeep Menon Ayyappankutty on 8/2/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import UIKit
import CoreData
public  class LogInHelper
{
    var dataMgr: DataManager? 
    var serviceMgr: ServiceManager?

    init ()
    {
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        serviceMgr = ServiceManager(objContext:manObjContext)
    }

    func Login(pin:String)
    {
        let status = false
        let serviceUrl:String = AppContext.svcUrl + "Login" as String
        let membershipId:String = AppContext.membershipUserID
        let token:String = CryptoUtility().generateSecurityToken() as String
        let params : Dictionary<String, String> = ["username":AppContext.membershipUserID, "pin":pin,"token":token]
        
        serviceMgr?.Login(["username":membershipId, "pin":pin, "token":token], url: serviceUrl, postCompleted:
            {
                (jsonData: NSDictionary?)->() in
  
            if let parseJSON = jsonData
            {
                var status = parseJSON["Status"] as? Int
                if(status == 1)
                {
                 self.dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedIn, isSecured: true)
                AppContext.loginStatus = LoginStatus.LoggedIn
                }
            }
        })
    }
    
}