//
//  StrategyDetailsViewController.swift
//  Headzup
//
//  Created by Matt Solano on 8/7/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class StrategyDetailsViewController: UIViewController {

    @IBOutlet weak var strategyDetailsTV: UITextView!
    var dataMgr: DataManager?
    var strategiesArray:Array<Content> = []
    var selectedStrategy : Content?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        var theContent = dataMgr?.getContentByID(selectedStrategy!.contentID as! Int)
        self.title = theContent?.contentName //"[Strategy Name]"
        self.strategyDetailsTV.text = theContent?.contentValue
        
        //UserActionTracking - ViewStrategy
        self.dataMgr?.saveUserActionLog(UserActions.ViewStrategy, actionDateTime: NSDate(), contentID: "", comment: "ViewStrategy", isSynched: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
