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
    public static let GoalCategory = "Goal_Category"
    public static let GoalView = "GoalView"
    public static let TrackerCategory = "Tracker_Category"
    public static let TrackerView = "TrackView"

}

public class NotificationHelper
{
    static func EnableGoalNotifcation()
    {
        var goalNotification: UILocalNotification = UILocalNotification()
        goalNotification.alertBody = "Your goal is overdue"
        goalNotification.alertAction = "Daily Challenge"
        
        let date = NSDate()
        goalNotification.fireDate = date
        
        goalNotification.soundName = UILocalNotificationDefaultSoundName // play default sound
        goalNotification.category = NotificationConstants.GoalCategory
        //goalNotification.userInfo = ["View": NotificationConstants.GoalView]
        goalNotification.timeZone = NSTimeZone.defaultTimeZone()
        goalNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        
        UIApplication.sharedApplication().scheduleLocalNotification(goalNotification)
        
        
    }
}