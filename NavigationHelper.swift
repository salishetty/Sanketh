//
//  NavigationHelper.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 7/20/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//
import Foundation
import UIKit
import CoreData

public extension UIViewController{
    
    func loadViewController(targetViewIdentifier:String)
    {
        let vc :AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier(targetViewIdentifier)
        if vc.isKindOfClass(UITabBarController)
        {
            let tabview = vc as! UITabBarController
            self.showViewController(tabview, sender: vc)
        }
        else
        {
         self.showViewController(vc as! UIViewController, sender: vc)
        }
    }
    
    func loadViewController(targetViewIdentifier:String,tabIndex:Int)
    {
        let vc :AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier(targetViewIdentifier)
        if vc.isKindOfClass(UITabBarController)
        {
            let tabview = vc as! UITabBarController
            self.showViewController(tabview, sender: vc)
            tabview.selectedIndex = tabIndex
        }
        else
        {
            self.showViewController(vc as! UIViewController, sender: vc)
        }
    }
}


public class NavigationHelper
{
    
    static func AuthanticateAndNavigate(sourceView:UIViewController,tagetView:String = "",targetID:Int = 0)
    {
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        let dataMgr = DataManager(objContext: manObjContext)
        AppContext.loginStatus = dataMgr.getMetaDataValue(MetaDataKeys.LoginStatus)
        AppContext.membershipUserID = dataMgr.getMetaDataValue(MetaDataKeys.MembershipUserID)
        if(AppContext.loginStatus ==  LoginStatus.LoggedIn)
        {
            if(tagetView.isEmpty)
            {
            sourceView.loadViewController("TabView",tabIndex: targetID)    
            }
            else
            {
              sourceView.loadViewController(tagetView,tabIndex: targetID)
            }
        }
        else if (AppContext.loginStatus ==  LoginStatus.LoggedOut && !AppContext.membershipUserID.isEmpty)
        {
            sourceView.loadViewController("PinView")
        }
        else
        {
            sourceView.loadViewController("LogInView")
        }

    }
}