//
//  Rule.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/28/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

public protocol Rule {
    func validate(value: String) -> Bool
    func errorMessage() -> String
}

