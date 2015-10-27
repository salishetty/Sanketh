//
//  HomeViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 7/27/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    var dataMgr: DataManager?
    var svcMgr: ServiceManager?
    
    @IBOutlet weak var greetingLB: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // init data
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        
        // Do any additional setup after loading the view.
        //Display greeting message
        let firstName =  dataMgr!.getMetaDataValue(MetaDataKeys.FirstName)
        greetingLB.text = "Hi, " + firstName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SynchTailoringQuestions(sender: UIButton) {
        let svcMgr = ServiceManager()
        //Synch Tailoring questions - to be removed later
        //SynchHelper.SynchTailoringQuestions(dataMgr!, svcMgr: svcMgr)
        SynchHelper.SynchTrackerQuestions(dataMgr!, svcMgr: svcMgr)
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
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
