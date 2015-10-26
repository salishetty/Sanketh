//
//  TrackerResponseItemsDTO.swift
//  Headzup
//
//  Created by Abebe Woreta on 10/13/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation
public class TrackerResponseItems
{
    var membershipUserId:String
    var trackDate: String
    var hadHeadache: NSNumber
    var painLevel: NSNumber
    var affectSleep: NSNumber
    var affectActivity: NSNumber
    var painReasons: String
    var helpfulContent: String
    init(membershipUserId:String, trackDate:String, hadHeadache: NSNumber, painLevel: NSNumber, affectSleep: NSNumber, affectActivity: NSNumber, painReasons: String, helpfulContent: String)
    {
        self.membershipUserId = membershipUserId
        self.trackDate = trackDate
        self.hadHeadache = hadHeadache
        self.painLevel = painLevel
        self.affectSleep = affectSleep
        self.affectActivity = affectActivity
        self.painReasons = painReasons
        self.helpfulContent = helpfulContent
    }
}