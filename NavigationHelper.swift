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
        if vc.isKindOfClass(UITabBarController)
        {
            let tabview = vc as! UITabBarController
            self.showViewController(tabview, sender: vc)
        }
        else
        {
         self.showViewController(vc as! UIViewController, sender: vc)
        }
    }
    
    func loadViewController(targetViewIdentifier:String,tabIndex:Int)
    {
        let vc :AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier(targetViewIdentifier)
        if vc.isKindOfClass(UITabBarController)
        {
            let tabview = vc as! UITabBarController
            self.showViewController(tabview, sender: vc)
            tabview.selectedIndex = tabIndex
        }
        else
        {
            self.showViewController(vc as! UIViewController, sender: vc)
        }
    }
    
}
