//
//  NavigationHelper.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 7/20/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//
import Foundation
import UIKit


public extension UIViewController{
    
    func loadViewController(targetViewIdentifier:String)
    {
        let vc :AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier(targetViewIdentifier)
        self.showViewController(vc as! UIViewController, sender: vc)
    }
}
