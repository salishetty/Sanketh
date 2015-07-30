//
//  ProfileViewController.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/30/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    //Add a reference to DataManger
    var dataMgr: DataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Logout(sender: UIButton) {
        // update login status
        dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedOut, isSecured: true)
        AppContext.loginStatus = LoginStatus.LoggedOut
        self.loadViewController("PinView")
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
