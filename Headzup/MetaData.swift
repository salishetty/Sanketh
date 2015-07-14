//
//  MetaData.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/14/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData

public class MetaData: NSManagedObject {

    @NSManaged var isSecured: NSNumber
    @NSManaged var name: String
    @NSManaged var value: String
    
    public func toString() -> String {
        return "(\(name):\(value))"
    }
}
