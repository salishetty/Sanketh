//
//  MinLengthRule.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/28/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

public class MinLengthRule: Rule {
    
    private var DEFAULT_LENGTH: Int = 3
    private var message : String = "Must be at least 3 characters long"
    
    public init(){}
    
    public init(length: Int, message : String = "Must be at least %ld characters long"){
        self.DEFAULT_LENGTH = length
        self.message = NSString(format: message, self.DEFAULT_LENGTH) as String
    }
    
    public func validate(value: String) -> Bool {
        return count(value) >= DEFAULT_LENGTH
    }
    
    public func errorMessage() -> String {
        return message
    }
}
