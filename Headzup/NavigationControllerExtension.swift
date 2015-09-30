//
//  NavigationControllerExtension.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/29/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation
import UIKit
extension UINavigationController {
    
    public override func childViewControllerForStatusBarHidden() -> UIViewController? {
        return self.topViewController
    }
    
    public override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.topViewController
    }
}

