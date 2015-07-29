//
//  PinRule.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/28/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

public class PinRule: RegexRule {
    
    public convenience init(message : String = "Enter a valid 4 digit pin"){
        self.init(regex: "^[a-zA-Z0-9]{4}$", message : message) 
    }
}
