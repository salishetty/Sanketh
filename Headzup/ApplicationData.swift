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
    
    public static var firstName = ""
    public static var loginStatus = ""
    public static var membershipUserID = ""
    public static let enc = false
    public static var userInfo = UserInfo()
    public static var categories:[Category]?
    public static var svcUrl = ""
    
    //public static func
    
    public static func list() {
        println("[loginStatus = \(loginStatus)]")
        println("[membershipUserID = \(membershipUserID)]")
        println("[firstName = \(firstName)]")
        
        var info = getUserInfo()
        println("[deviceId = \(info.deviceId)]")
        println("[deviceType = \(info.deviceType)]")
        println("[svcUrl = \(svcUrl)]")
    }
    
    public static func getUserInfo() -> UserInfo {
        var info = UserInfo()
        info.userId = membershipUserID
        return info
    }
    public static func hasConnectivity() -> Bool {
        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().value
        return networkStatus != 0
    }
}

