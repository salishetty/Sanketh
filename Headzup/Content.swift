//
//  Content.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/29/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData

public class Content: NSManagedObject {

    @NSManaged var contentID: NSNumber
    @NSManaged var contentType: NSNumber
    @NSManaged var contentName: String
    @NSManaged var contentDescription: String
    @NSManaged var contentValue: String
    @NSManaged var imagePath: String
    @NSManaged var audioPath: String

    public func toString() -> String {
        return "content: \(contentID): \(contentName) \n [\(contentValue)]"
    }
}
