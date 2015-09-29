//
//  CustomDatePicker.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/29/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation
import UIKit
class CustomDatePicker: UIDatePicker {
    var changed = false
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func drawRect(rect: CGRect) {
        layer.cornerRadius = 8
        layer.borderColor = UIColor(hex:0x5DB8EB,alpha:1).CGColor
        layer.borderWidth = 1
        layer.masksToBounds = false
    }
    
    override func addSubview(view: UIView) {
        if !changed {
            changed = true
            self.clipsToBounds = true
            self.backgroundColor = UIColor.whiteColor()
            self.setValue(UIColor(hex:0x78AC2D,alpha:1), forKey: "textColor")
            self.layer.masksToBounds = false
         }
        super.addSubview(view)
    }
}