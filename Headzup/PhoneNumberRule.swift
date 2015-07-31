//
//  PhoneNumberRule.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/31/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

public class PhoneRule: RegexRule {
    
    
    static let regex = "\\(?([0-9]{3})\\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})"
    
    public convenience init(message : String = "Must be a valid phone number"){
        self.init(regex: PhoneRule.regex, message: message)
    }
}
