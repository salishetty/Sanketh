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
    public static let GoalCategory = "GoalCategory"
    public static let GoalComplete = "GoalComplete"
    public static let GoalView = "GoalView"
    public static let TrackerCategory = "TrackerCategory"
    public static let TrackerComplete = "TrackerComplete"
    public static let TrackerView = "TrackView"
}

public class NotificationHelper
{
    static func EnableTrackerNotifcation(datetime:NSDate)
    {
        var trackerNotification: UILocalNotification = UILocalNotification()
        trackerNotification.alertBody = "Please update tracker"
        trackerNotification.alertAction = "Daily Tracker"
        
        trackerNotification.fireDate = datetime
        
        trackerNotification.soundName = UILocalNotificationDefaultSoundName // play default sound
        trackerNotification.category = NotificationConstants.GoalCategory
        //goalNotification.userInfo = ["View": NotificationConstants.GoalView]
        trackerNotification.timeZone = NSTimeZone.defaultTimeZone()
        trackerNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(trackerNotification)
        
        
    }
    
    static func DisableTrackerNotifcation(datetime:NSDate)
    {
        
    }
    
    static func SetupTrackerNotification(application: UIApplication)
    {
        let completeAction = UIMutableUserNotificationAction()
        completeAction.identifier = NotificationConstants.TrackerComplete
        completeAction.title = "Complete"
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
    
   
}