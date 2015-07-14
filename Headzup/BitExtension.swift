//
//  BitExtension.swift
//  HeadzupPOC
//
//  Created by Abebe Woreta on 5/15/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

extension Bit {
    
    func inverted() -> Bit {
        if (self == Bit.Zero) {
            return Bit.One
        }
        
        return Bit.Zero
    }
    
    mutating func invert()  {
        self = self.inverted()
    }
}
