//
//  NotificationTests.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 8/2/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import UIKit
import XCTest

class NotificationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNotification() {
        
        var notification = UILocalNotification()
        notification.alertBody = "your goal is overdue" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        let date = NSDate()
        notification.fireDate = date // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.category = "GOAL_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    
}
