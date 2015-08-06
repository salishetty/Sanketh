//
//  UserActionLog.swift
//  Headzup
//
//  Created by Abebe Woreta on 8/5/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData

public class UserActionLog: NSManagedObject {

    @NSManaged var actionDateTime: NSDate
    @NSManaged var actionType: String
    @NSManaged var appVersion: String
    @NSManaged var comment: String
    @NSManaged var contentID: String
    @NSManaged var isSynched: NSNumber
    @NSManaged var osVersion: String
    public func toString() -> String {
        return "- action: \(actionType): \(actionDateTime), \(comment), \(contentID), \(appVersion)"
    }
}
