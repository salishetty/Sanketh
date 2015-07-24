//
//  ApplicationData.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/14/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import SystemConfiguration
import Foundation
import UIKit

public class UserInfo {
    public var userId = ""
    public var deviceId = UIDevice.currentDevice().identifierForVendor.UUIDString
    public var deviceType =  UIDevice.currentDevice().model
}


public class AppContext {
    
    public static var userName = ""
    public static var loginStatus = ""
    public static var phoneNumber = ""
    public static var pin = ""
    public static let enc = false
    public static var userInfo = UserInfo()
    
    public static var svcUrl = ""
    
    //public static func
    
    public static func list() {
        println("[loginStatus = \(loginStatus)]")
        println("[phone = \(phoneNumber)]")
        println("[userName = \(userName)]")
        println("[pin = \(pin)]")
        var info = getUserInfo()
        println("[deviceId = \(info.deviceId)]")
        println("[deviceType = \(info.deviceType)]")
        println("[svcUrl = \(svcUrl)]")
    }
    
    public static func getUserInfo() -> UserInfo {
        var info = UserInfo()
        info.userId = phoneNumber
        return info
    }
}

