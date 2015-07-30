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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        var dataMgr = DataManager(objContext: manObjContext)
        super.viewDidAppear(animated)
        AppContext.loginStatus = dataMgr.getMetaDataValue(MetaDataKeys.LoginStatus)
        
        if(AppContext.loginStatus ==  LoginStatus.LoggedIn)
        {
            self.loadViewController("TabView")
        
        }
        else if (!AppContext.membershipUserID.isEmpty)
        {
            self.loadViewController("PinView")
        }
        else
        {
            self.loadViewController("LogInView")
        }
        
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
