//
//  SplashViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 7/21/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadGoalView:",name:"GoalNotificationObserver", object: nil)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        NavigationHelper.AuthanticateAndNavigate(self,tagetView: "")
    }

    
    func loadGoalView(notification: NSNotification){
        NavigationHelper.AuthanticateAndNavigate(self,tagetView: "TabView",targetID:0)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
