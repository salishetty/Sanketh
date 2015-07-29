//
//  RequiredRule.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/28/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

public class RequiredRule: Rule {
    
    private var message : String
    
    public init(message : String = "This field is required"){
        self.message = message
    }
    
    public func validate(value: String) -> Bool {
        return !value.isEmpty
    }
    
    public func errorMessage() -> String {
        return message
    }
}
