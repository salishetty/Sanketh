//
//  NotificationHelper.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 8/5/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public struct NotificationConstants {
    
    public static let GoalName : String = "GoalNotification"
    public static let GoalCategory : String = "GoalCategory"
    public static let GoalComplete : String = "GoalComplete"
    public static let GoalView : String = "GoalView"
    
    public static let TrackerName : String = "TrackerNotification"
    static let TrackerCategory : String = "TrackerCategory"
    static let TrackerComplete : String = "TrackerComplete"
    public static let TrackerView : String = "TrackView"
}

public class NotificationHelper
{
    
    static func DisableNotification(Name : String)
    {
        
        var notifyArray = UIApplication.sharedApplication().scheduledLocalNotifications
        for notifyCancel in notifyArray as! [UILocalNotification]{
            
            let info: [String: String] = notifyCancel.userInfo as! [String: String]
            
            if info["Name"] == Name
            {
                UIApplication.sharedApplication().cancelLocalNotification(notifyCancel)
            
            }
            else
            {
                println("No Local Notification Found!")
            }
        }
    }
    
    
    static func UpdateGoalNotification(Name : String, goalName: String)
    {
        var notifyArray = UIApplication.sharedApplication().scheduledLocalNotifications
        var datetime:NSDate = NSDate()
        for notifyCancel in notifyArray as! [UILocalNotification]{
            
            let info: [String: String] = notifyCancel.userInfo as! [String: String]
            
            if info["Name"] == Name
            {
                datetime = notifyCancel.fireDate!
                UIApplication.sharedApplication().cancelLocalNotification(notifyCancel)
                
            }
            else
            {
                println("No Local Notification Found!")
            }
        }
        
        let tomorrow = NSCalendar.currentCalendar().dateByAddingUnit(
            .CalendarUnitMinute,
            value: 2,
            toDate: datetime,
            options: NSCalendarOptions(0))
        EnableGoalNotifcation(tomorrow!, goalName: goalName)

    }

    
    static func SetupTrackerNotification(application: UIApplication)
    {
        let completeAction = UIMutableUserNotificationAction()
        completeAction.identifier = NotificationConstants.TrackerComplete
        completeAction.title = "Go"
        completeAction.activationMode = UIUserNotificationActivationMode.Foreground
        completeAction.authenticationRequired = true
        completeAction.destructive = false
        
        let trackerCategory = UIMutableUserNotificationCategory()
        trackerCategory.identifier = NotificationConstants.TrackerCategory
        trackerCategory.setActions([completeAction], forContext: .Default)
        trackerCategory.setActions([completeAction], forContext: .Minimal)
        
        let notificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
        let categories = NSSet(array: [trackerCategory])
        let settings = UIUserNotificationSettings(forTypes: notificationType, categories: categories as Set<NSObject>)
        application.registerUserNotificationSettings(settings)
        
    }
    static func EnableTrackerNotifcation(datetime:NSDate)
    {
        var trackerNotification: UILocalNotification = UILocalNotification()
        trackerNotification.alertBody = "Don’t forget to track your headache pain even if you haven’t had a headache."
        //trackerNotification.alertAction = "Complete"
        trackerNotification.fireDate = datetime
        trackerNotification.repeatInterval = NSCalendarUnit.CalendarUnitMinute
        trackerNotification.soundName = UILocalNotificationDefaultSoundName // play default sound
        trackerNotification.category = NotificationConstants.TrackerCategory
        trackerNotification.userInfo = ["Name": NotificationConstants.TrackerName]
        trackerNotification.timeZone = NSTimeZone.defaultTimeZone()
        trackerNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(trackerNotification)
        
    }

   
    static func SetupGoalNotification(application: UIApplication)
    {
        let completeGoal = UIMutableUserNotificationAction()
        completeGoal.identifier = NotificationConstants.GoalComplete
        completeGoal.title = "Goal"
        completeGoal.activationMode = UIUserNotificationActivationMode.Foreground
        completeGoal.authenticationRequired = true
        completeGoal.destructive = false
        
        
        let goalCategory = UIMutableUserNotificationCategory()
        goalCategory.identifier = NotificationConstants.GoalCategory
        goalCategory.setActions([completeGoal], forContext: .Default)
        goalCategory.setActions([completeGoal], forContext: .Minimal)
        
        let notificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
        let categories = NSSet(array: [goalCategory])
        let settings = UIUserNotificationSettings(forTypes: notificationType, categories: categories as Set<NSObject>)
        application.registerUserNotificationSettings(settings)
   
    }

    static func EnableGoalNotifcation(datetime:NSDate , goalName: String )
    {
        var goalNotification: UILocalNotification = UILocalNotification()
        goalNotification.alertBody = "Your Headzup goal today: " + goalName
        //goalNotification.alertAction = "Goal"
        goalNotification.fireDate = datetime
        goalNotification.repeatInterval = NSCalendarUnit.CalendarUnitMinute
        goalNotification.soundName = UILocalNotificationDefaultSoundName // play default sound
        goalNotification.category = NotificationConstants.GoalCategory
        goalNotification.userInfo = ["Name": NotificationConstants.GoalName]
        goalNotification.timeZone = NSTimeZone.defaultTimeZone()
        goalNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(goalNotification)
        
    }

    static func notificationRedirect(notification: UILocalNotification)
    {
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        var dataMgr = DataManager(objContext: manObjContext)
        AppContext.loginStatus = dataMgr.getMetaDataValue(MetaDataKeys.LoginStatus)
        
        println("[loginStatus = \(AppContext.loginStatus)]")
   
        if notification.category == NotificationConstants.GoalCategory
        {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if (AppContext.loginStatus == LoginStatus.LoggedIn)
            {
                var tabVC = mainStoryboard.instantiateViewControllerWithIdentifier("TabView") as! UITabBarController
                tabVC.selectedIndex = 1
                theAppDelegate.window!.rootViewController = tabVC
            }
            else
            {
                var pinVC = mainStoryboard.instantiateViewControllerWithIdentifier("PinView") as! PinViewController
                pinVC.TabIndex = 2
                theAppDelegate.window!.rootViewController = pinVC
            }
        }
        else if notification.category == NotificationConstants.TrackerCategory
        {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if (AppContext.loginStatus == LoginStatus.LoggedIn)
            {
                var tabVC = mainStoryboard.instantiateViewControllerWithIdentifier("TabView") as! UITabBarController
                tabVC.selectedIndex = 1
                theAppDelegate.window!.rootViewController = tabVC
            }
            else
            {
                var pinVC = mainStoryboard.instantiateViewControllerWithIdentifier("PinView") as! PinViewController
                pinVC.TabIndex = 2
                theAppDelegate.window!.rootViewController = pinVC
            }
        }

    }
    
    
}