//
//  TechnicalLog.swift
//  Headzup
//
//  Created by Abebe Woreta on 8/5/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData

public class TechnicalLog: NSManagedObject {

    @NSManaged var appVersion: String
    @NSManaged var eventDate: String
    @NSManaged var exception: String
    @NSManaged var isSynched: NSNumber
    @NSManaged var logLevel: String
    @NSManaged var message: String
    @NSManaged var moduleName: String
    @NSManaged var osVersion: String
    
    public func toString() -> String {
        return "- technicalLog: \(moduleName): \(eventDate), \(logLevel), \(appVersion), \(osVersion)"
    }
}
