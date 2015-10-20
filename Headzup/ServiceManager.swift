//
//  ServiceManager.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/14/15.
//  Refactored by Sandeep Menon on 09/23/15
//  Copyright (c) 2015 Inflexxion. All rights reserved.

import Foundation
import SwiftyJSON
public struct ServiceManager
{
    func Login(params : Dictionary<String, String>, completion : (jsonData: JSON?) -> ())
    {
        guard let theURL:NSURL =  NSURL(string:AppContext.svcUrl + SeriviceApi.Login.key)
            else
        {
            print("Could not construct a valid login URL")
            return
        }
        let networkOperation = NetworkOperation(url: theURL)
        networkOperation.Post(params) { (let dataJSON) -> Void in
                completion(jsonData: dataJSON)
        }
    }
    
    func synchUserActions(params : Dictionary<String,Dictionary<String, String>>, completion : (jsonData: JSON?) -> ())
    {
        guard let theURL:NSURL =  NSURL(string:AppContext.svcUrl + SeriviceApi.UserAction.key)
            else
        {
            print("Could not construct a valid user action URL")
            return
        }
        let networkOperation = NetworkOperation(url: theURL)
        networkOperation.Post(params) { (let dataJSON) -> Void in
            completion(jsonData: dataJSON)
        }
    }
    
    func synchTechnicalLog(params : Dictionary<String,Dictionary<String, String>>, completion : (jsonData: JSON?) -> ())
    {
        guard let theURL:NSURL =  NSURL(string:AppContext.svcUrl + SeriviceApi.TechnicalLog.key)
            else
        {
            print("Could not construct a valid tech log URL")
            return
        }
        let networkOperation = NetworkOperation(url: theURL)
        networkOperation.Post(params) { (let dataJSON) -> Void in
            completion(jsonData: dataJSON)
        }
    }
    
    func synchFavorites(params : Dictionary<String,Dictionary<String, String>>, completion : (jsonData: JSON?) -> ())
    {
        guard let theURL:NSURL =  NSURL(string:AppContext.svcUrl + SeriviceApi.Favorite.key)
            else
        {
            print("Could not construct a valid favorite URL")
            return
        }
        let networkOperation = NetworkOperation(url: theURL)
        networkOperation.Post(params) { (let dataJSON) -> Void in
            completion(jsonData: dataJSON)
        }
    }
    
    func synchAboutMeResponse(params : Dictionary<String,Dictionary<String, String>>, completion : (jsonData: JSON?) -> ())
    {
        guard let theURL:NSURL =  NSURL(string:AppContext.svcUrl + SeriviceApi.AboutMe.key)
            else
        {
            print("Could not construct a valid About Me URL")
            return
        }
        let networkOperation = NetworkOperation(url: theURL)
        networkOperation.Post(params) { (let dataJSON) -> Void in
            completion(jsonData: dataJSON)
        }
    }
    func synchTrackerResponse(params : Dictionary<String,Dictionary<String, String>>, completion : (jsonData: JSON?) -> ())
    {
        guard let theURL:NSURL =  NSURL(string:AppContext.svcUrl + SeriviceApi.TrackerResponse.key)
            else
        {
            print("Could not construct a valid About Me URL")
            return
        }
        let networkOperation = NetworkOperation(url: theURL)
        networkOperation.Post(params) { (let dataJSON) -> Void in
            completion(jsonData: dataJSON)
        }
    }
    
    func getContent(completion : (jsonData: JSON?) -> ())
    {
        guard let theURL:NSURL =  NSURL(string:AppContext.svcUrl + SeriviceApi.Contents.key)
            else
        {
            print("Could not construct a valid content url")
            return
        }
        let networkOperation = NetworkOperation(url: theURL)
        networkOperation.Get{ (let dataJSON) -> Void in
            completion(jsonData: dataJSON)
        }
    }
    
    func getFirstAidContent(completion : (jsonData: JSON?) -> ())
    {
        guard let theURL:NSURL =  NSURL(string:AppContext.svcUrl + SeriviceApi.FirstAid.key)
            else
        {
            print("Could not construct a valid first aid content url")
            return
        }
        let networkOperation = NetworkOperation(url: theURL)
        networkOperation.Get{ (let dataJSON) -> Void in
            completion(jsonData: dataJSON)
        }
    }
}

enum SeriviceApi {
    case Login
    case AboutMe
    case Contents
    case FirstAid
    case TechnicalLog
    case UserAction
    case Favorite
    case TrackerResponse
    
    var key: String {
        get {
            switch self {
            case .Contents: return "getContents"
            case .AboutMe: return "SynchAboutMeResponse"
            case .Login: return "Login"
            case .FirstAid: return "getFirstAidContents"
            case .TechnicalLog: return "SynchTechnicalLogItems"
            case .UserAction: return "TrackUserAction"
            case .Favorite: return "SynchFavoriteItems"
            case .TrackerResponse: return "SynchTrackerResponse"
            }
        }
    }
}
