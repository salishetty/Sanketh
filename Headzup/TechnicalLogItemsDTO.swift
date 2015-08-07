//
//  TechnicalLogItemsDTO.swift
//  Headzup
//
//  Created by Abebe Woreta on 8/5/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
public class TechnicalLogItems
{
    var message:String
    var deviceId:String
    var exception:String
    var moduleName:String
    var eventDate:String
    var appVersion:String
    var osVersion:String
    var logLevel:String
    
    init(message:String, deviceId:String, exception:String, moduleName:String, eventDate:String, appVersion:String, osVersion:String, logLevel:String)
    {
        self.message = message
        self.deviceId = deviceId
        self.exception = exception
        self.moduleName = moduleName
        self.eventDate = eventDate
        self.osVersion = osVersion
        self.appVersion = appVersion
        self.logLevel = logLevel
    }
}

