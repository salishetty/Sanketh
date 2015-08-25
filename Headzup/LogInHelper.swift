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
    class func isDisabled() -> Bool
    {
        var result = false

        var dataMgr: DataManager?
        var serviceMgr: ServiceManager?
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        serviceMgr = ServiceManager(objContext:manObjContext)
        
        let serviceUrl:String = AppContext.svcUrl + "Login" as String
        let membershipId:String = AppContext.membershipUserID
        let token:String = CryptoUtility().generateSecurityToken() as String

        serviceMgr?.Login(["username":membershipId,"token":token], url: serviceUrl, postCompleted:
            {
                (jsonData: NSDictionary?)->() in
            if let parseJSON = jsonData
                {
                    var status = parseJSON["Status"] as? String
                    if(status == "2")
                    {
                        dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedOut, isSecured: true)
                        AppContext.loginStatus = LoginStatus.LoggedOut
                        result = true
                    }
                }
        })
        return result
    }
}

    
    
    
