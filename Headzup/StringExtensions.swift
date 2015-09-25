//
//  StringExtensions.swift
//  Headzup
//
//  Created by Abebe Woreta on 9/23/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation

extension String {
    var pathExtension: String? {
        return NSString(string: self).pathExtension
    }
    var lastPathComponent: String? {
        return NSString(string: self).lastPathComponent
    }
}
