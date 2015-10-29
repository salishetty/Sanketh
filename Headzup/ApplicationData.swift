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
    public var membershipUserID = ""
    public var deviceId = UIDevice.currentDevice().identifierForVendor!.UUIDString
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
    public static var currentView = "HomeView"
    public static var trackDate = NSDate?()
    public static var painReasonsResponseValue = ""
    public static var EffectivenessResponseValue = ""
    public static var strategies = [[String]]()
    //public static func
    
    public static func list() {
        print("[loginStatus = \(loginStatus)]")
        print("[membershipUserID = \(membershipUserID)]")
        print("[firstName = \(firstName)]")
        
        let info = getUserInfo()
        print("[deviceId = \(info.deviceId)]")
        print("[deviceType = \(info.deviceType)]")
        print("[svcUrl = \(svcUrl)]")
    }
    
    public static func getUserInfo() -> UserInfo {
        let info = UserInfo()
        info.membershipUserID = membershipUserID
        return info
    }
    public static func hasConnectivity() -> Bool {
        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        return networkStatus != 0
    }
}

