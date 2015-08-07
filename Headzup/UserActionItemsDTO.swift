//
//  UserActionItemsDTO.swift
//  Headzup
//
//  Created by Abebe Woreta on 8/5/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

public class UserActionItems
{
    var userId:String
    var deviceId:String
    var deviceType:String
    var actionDate:String
    var osVersion:String
    var appVersion:String
    var actionType:String
    var comment:String
    
    init(userId:String, deviceId:String, deviceType:String, actionDate:String, osVersion:String, appVersion:String, actionType:String, comment:String)
    {
        self.userId = userId
        self.deviceId = deviceId
        self.deviceType = deviceType
        self.actionDate = actionDate
        self.osVersion = osVersion
        self.appVersion = appVersion
        self.actionType = actionType
        self.comment = comment
    }
}