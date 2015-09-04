//
//  ServiceManager.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/14/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData

public class ServiceManager:NSObject, NSURLSessionDelegate, NSURLSessionTaskDelegate
{
    var dbContext: NSManagedObjectContext!
    public init(objContext: NSManagedObjectContext) {
        self.dbContext = objContext
    }
    public func Login(params : Dictionary<String, String>, url : String, postCompleted : (jsonData: NSDictionary?) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var session = NSURLSession(configuration: configuration, delegate: self, delegateQueue:NSOperationQueue.mainQueue())
        //var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        var json:NSDictionary?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Message: \(strData)")
            var err: NSError?
            json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else { //if no error
                postCompleted(jsonData: json!)
            }
        })
        
        task.resume()
        
    }
    public func synchUserActions(params : Dictionary<String,Dictionary<String, String>>, url : String, postCompleted : (jsonData: NSDictionary?) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        var json:NSDictionary?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Message: \(strData)")
            var err: NSError?
            json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else { //if no error
                postCompleted(jsonData: json!)
            }
        })
        
        task.resume()
        
    }
    
    public func synchTechnicalLog(params : Dictionary<String,Dictionary<String, String>>, url : String, postCompleted : (jsonData: NSDictionary?) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        var json:NSDictionary?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Message: \(strData)")
            var err: NSError?
            json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else { //if no error
                postCompleted(jsonData: json!)
            }
        })
        
        task.resume()
        
    }
    public func synchFavorites(params : Dictionary<String,Dictionary<String, String>>, url : String, postCompleted : (jsonData: NSDictionary?) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        var json:NSDictionary?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Message: \(strData)")
            var err: NSError?
            json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else { //if no error
                postCompleted(jsonData: json!)
            }
        })
        
        task.resume()
        
    }
    
    public func getContent(url : String, postCompleted : (jsonData: NSArray) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        var err: NSError?
        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println("Message: \(strData)")
            var err: NSError?
            if let json:NSArray = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSArray
            {
                if NSJSONSerialization.isValidJSONObject(json)
                {
                    postCompleted(jsonData: json)
                    println("JSON is valid")
                }
            }
            else {
                println(err!.localizedDescription)
                
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
        })
        
        task.resume()
        
    }

    public func getFirstAidContent(url : String, postCompleted : (jsonData: NSArray) -> ()) {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        var err: NSError?
        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println("Message: \(strData)")
            var err: NSError?
            if let json:NSArray = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSArray
            {
                if NSJSONSerialization.isValidJSONObject(json)
                {
                    postCompleted(jsonData: json)
                    println("JSON is valid")
                }
            }
            else {
                println(err!.localizedDescription)
                
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
        })
        
        task.resume()
    }
    
    public func URLSession(session: NSURLSession,didReceiveChallenge challenge:NSURLAuthenticationChallenge,
        completionHandler:(NSURLSessionAuthChallengeDisposition,
        NSURLCredential!) -> Void)
    {
        completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential,
            NSURLCredential(forTrust:challenge.protectionSpace.serverTrust))
    }
    
    public func URLSession(session: NSURLSession, task: NSURLSessionTask, willPerformHTTPRedirection response: NSHTTPURLResponse, newRequest request: NSURLRequest, completionHandler: (NSURLRequest!) -> Void)
    {
        var newRequest : NSURLRequest? = request
        println(newRequest?.description);
        completionHandler(newRequest)
    }
    
    //Helper Methods
    private func doSynchronize(params:Dictionary<String, Dictionary<String, String>>, url : String, postCompleted : (jsonData: NSDictionary?) -> ())
    {
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        var json:NSDictionary?
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Message: \(strData)")
            var err: NSError?
            json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
            }
            else { //if no error
                postCompleted(jsonData: json!)
            }
        })
        
        task.resume()
}
}