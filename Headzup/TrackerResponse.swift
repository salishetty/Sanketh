//
//  TrackerResponse.swift
//  Headzup
//
//  Created by Abebe Woreta on 10/13/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData

public class TrackerResponse: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    @NSManaged var trackDate: NSDate
    @NSManaged var hadHeadache: NSNumber
    @NSManaged var painLevel: NSNumber
    @NSManaged var affectSleep: NSNumber
    @NSManaged var affectActivity: NSNumber
    @NSManaged var painReasons: String
    @NSManaged var helpfulContent: String
    public func toString() -> String {
        return "TrackerResponse: \(trackDate), \(hadHeadache), \(painLevel), \(affectSleep), \(affectActivity), \(painReasons), \(helpfulContent)"
    }

}
