//
//  ServiceManager.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/14/15.
//  Updated by Sandeep Menon on 09/23/15
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
   
    public func Login(params : Dictionary<String, String>, completion : (jsonData: NSDictionary?) -> ())
    {
        guard let theURL:NSURL =  NSURL(string:AppContext.svcUrl + "Login")
            else
        {
            print("Could not construct a valid URL")
            return
        }
        let networkOperation = NetworkOperation(url: theURL)
        networkOperation.Post(params) { (let jsonDictionary) -> Void in
            if let dataJSON = jsonDictionary
            {
                completion(jsonData: dataJSON)
            }
        }
        
    }
    
    
    
    
    public func synchUserActions(params : Dictionary<String,Dictionary<String, String>>, url : String, swif : (jsonData: NSDictionary?) -> ()) {
//        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
//        var session = NSURLSession.sharedSession()
//        request.HTTPMethod = "POST"
//        
//        var err: NSError?
//        var json:NSDictionary?
//        
//        do {
//            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
//        } catch var error as NSError {
//            err = error
//            request.HTTPBody = nil
//        }
//        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
//        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
//        
//        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            print("Response: \(response)")
//            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("Message: \(strData)")
//            var err: NSError?
//            json = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
//            
//            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//            if(err != nil) {
//                print(err!.localizedDescription)
//                
//                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print("Error could not parse JSON: '\(jsonStr)'")
//            }
//            else { //if no error
//                postCompleted(jsonData: json!)
//            }
//        })
//        
//        task.resume()
        
    }
    
    public func synchTechnicalLog(params : Dictionary<String,Dictionary<String, String>>, url : String, postCompleted : (jsonData: NSDictionary?) -> ()) {
//        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
//        let session = NSURLSession.sharedSession()
//        request.HTTPMethod = "POST"
//        
//        var err: NSError?
//        var json:NSDictionary?
//        
//        do {
//            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
//        } catch let error as NSError {
//            err = error
//            request.HTTPBody = nil
//        }
//        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
//        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
//        
//        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            print("Response: \(response)")
//            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("Message: \(strData)")
//            let err: NSError?
//            json = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
//            
//            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//            if(err != nil) {
//                print(err!.localizedDescription)
//                
//                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print("Error could not parse JSON: '\(jsonStr)'")
//            }
//            else { //if no error
//                postCompleted(jsonData: json!)
//            }
//        })
        
//        task.resume()
        
    }
    public func synchFavorites(params : Dictionary<String,Dictionary<String, String>>, url : String, postCompleted : (jsonData: NSDictionary?) -> ()) {
//        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
//        var session = NSURLSession.sharedSession()
//        request.HTTPMethod = "POST"
//        
//        var err: NSError?
//        var json:NSDictionary?
//        
//        do {
//            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
//        } catch var error as NSError {
//            err = error
//            request.HTTPBody = nil
//        }
//        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
//        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
//        
//        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            print("Response: \(response)")
//            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("Message: \(strData)")
//            var err: NSError?
//            json = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
//            
//            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//            if(err != nil) {
//                print(err!.localizedDescription)
//                
//                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print("Error could not parse JSON: '\(jsonStr)'")
//            }
//            else { //if no error
//                postCompleted(jsonData: json!)
//            }
//        })
        
//        task.resume()
        
    }
    
    public func getContent(url : String, postCompleted : (jsonData: NSArray) -> ()) {
//        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
//        var session = NSURLSession.sharedSession()
//        request.HTTPMethod = "GET"
//        
//        var err: NSError?
//        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
//        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
//        
//        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            print("Response: \(response)")
//            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            //println("Message: \(strData)")
//            var err: NSError?
//            if let json:NSArray = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSArray
//            {
//                if NSJSONSerialization.isValidJSONObject(json)
//                {
//                    postCompleted(jsonData: json)
//                    print("JSON is valid")
//                }
//            }
//            else {
//                print(err!.localizedDescription)
//                
//                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print("Error could not parse JSON: '\(jsonStr)'")
//            }
//        })
        
//        task.resume()
        
    }

    public func getFirstAidContent(url : String, postCompleted : (jsonData: NSArray) -> ()) {
//        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
//        var session = NSURLSession.sharedSession()
//        request.HTTPMethod = "GET"
//        
//        var err: NSError?
//        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
//        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
//        
//        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            print("Response: \(response)")
//            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            //println("Message: \(strData)")
//            var err: NSError?
//            if let json:NSArray = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSArray
//            {
//                if NSJSONSerialization.isValidJSONObject(json)
//                {
//                    postCompleted(jsonData: json)
//                    print("JSON is valid")
//                }
//            }
//            else {
//                print(err!.localizedDescription)
//                
//                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print("Error could not parse JSON: '\(jsonStr)'")
//            }
//        })
//        
//        task.resume()
    }
    
    public func synchAboutMeResponse(params : Dictionary<String,Dictionary<String, String>>, url : String, postCompleted : (jsonData: NSDictionary?) -> ()) {
//        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
//        var session = NSURLSession.sharedSession()
//        request.HTTPMethod = "POST"
//        
//        var err: NSError?
//        var json:NSDictionary?
//        
//        do {
//            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
//        } catch var error as NSError {
//            err = error
//            request.HTTPBody = nil
//        }
//        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
//        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
//        
//        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            print("Response: \(response)")
//            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("Message: \(strData)")
//            var err: NSError?
//            json = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
//            
//            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//            if(err != nil) {
//                print(err!.localizedDescription)
//                
//                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print("Error could not parse JSON: '\(jsonStr)'")
//            }
//            else { //if no error
//                postCompleted(jsonData: json!)
//            }
//        })
//        
//        task.resume()
//        
    }

    public func URLSession(session: NSURLSession,didReceiveChallenge challenge:NSURLAuthenticationChallenge,
        completionHandler:(NSURLSessionAuthChallengeDisposition,
        NSURLCredential?) -> Void)
    {
        completionHandler(NSURLSessionAuthChallengeDisposition.UseCredential,
            NSURLCredential(forTrust:challenge.protectionSpace.serverTrust!))
    }
    
    public func URLSession(session: NSURLSession, task: NSURLSessionTask, willPerformHTTPRedirection response: NSHTTPURLResponse, newRequest request: NSURLRequest, completionHandler: (NSURLRequest?) -> Void)
    {
        let newRequest : NSURLRequest? = request
        print(newRequest?.description);
        completionHandler(newRequest)
    }
    
    //Helper Methods
    private func doSynchronize(params:Dictionary<String, Dictionary<String, String>>, url : String, postCompleted : (jsonData: NSDictionary?) -> ())
    {
//        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
//        var session = NSURLSession.sharedSession()
//        request.HTTPMethod = "POST"
//        
//        var err: NSError?
//        var json:NSDictionary?
//        
//        do {
//            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [])
//        } catch var error as NSError {
//            err = error
//            request.HTTPBody = nil
//        }
//        request.addValue("text/javascript", forHTTPHeaderField: "Content-Type")
//        request.addValue("text/javascript", forHTTPHeaderField: "Accept")
//        
//        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//            print("Response: \(response)")
//            var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("Message: \(strData)")
//            var err: NSError?
//            json = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
//            
//            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//            if(err != nil) {
//                print(err!.localizedDescription)
//                
//                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print("Error could not parse JSON: '\(jsonStr)'")
//            }
//            else { //if no error
//                postCompleted(jsonData: json!)
//            }
//        })
//        
//        task.resume()
}
}