//
//  NetworkOperation.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/23/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation

class NetworkOperation : NSURLSession
{
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    
    typealias JSONDictionaryCompletion = ([String:AnyObject]?) -> Void
    
    init(url: NSURL) {
        self.queryURL = url
    }
    
    func Get(completion: JSONDictionaryCompletion) {
        let request = NSURLRequest(URL: queryURL)
        
        let dataTask = session.dataTaskWithRequest(request) {
            (let data: NSData?, let response: NSURLResponse?, let error: NSError?) -> Void in
            
            // 1: Check HTTP Response for successful GET request
            guard let httpResponse = response as? NSHTTPURLResponse, receivedData = data
                else {
                    print("Error: not a valid http response")
                    return
            }
            
            switch (httpResponse.statusCode) {
            case 200:
                // 2: Create JSON object with data
                do {
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.AllowFragments)
                        as? [String:AnyObject]
                    
                     // 3: Pass the json back to the completion handler
                    completion(jsonDictionary)
                    print("JSON is valid")
                    
                } catch {
                    print("error parsing json data")
                }
            default:
                print("GET request got response \(httpResponse.statusCode)")
            }
        }
        dataTask.resume()
    }
    
    
    
    func Post(var body: [String: AnyObject],completion: JSONDictionaryCompletion) {
        
        let token:String = CryptoUtility().generateSecurityToken() as String
        body.updateValue(token, forKey: "token")
        
        let request = NSMutableURLRequest(URL: queryURL)
        request.HTTPMethod = "POST"
        do
        {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(body, options: [])
        } catch
        {
            
            request.HTTPBody = nil
        }
        let dataTask = session.dataTaskWithRequest(request) {
            (let data: NSData?, let response: NSURLResponse?, let error: NSError?) -> Void in
            
            // 1: Check HTTP Response for successful POST request
            guard let httpResponse = response as? NSHTTPURLResponse, receivedData = data
                else {
                    print("Error: not a valid http response")
                    return
            }
            
            switch (httpResponse.statusCode) {
            case 200:
                // 2: Create JSON object with data
                do {
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.AllowFragments)
                        as? [String:AnyObject]
                    
                    // 3: Pass the json back to the completion handler
                    completion(jsonDictionary)
                } catch {
                    print("error parsing json data")
                }
            default:
                print("POST request got response \(httpResponse.statusCode)")
            }
        }
        dataTask.resume()
        
    }
    
}



