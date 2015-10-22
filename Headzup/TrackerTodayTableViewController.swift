//
//  TrackerTodayTableViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 10/14/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class TrackerTodayTableViewController: UITableViewController {
    var dataMgr: DataManager?
    @IBOutlet weak var labelQ1: UILabel!
    @IBOutlet weak var sliderQ1: UISlider!

    @IBOutlet weak var buttonQ2: CustomButton!

    @IBOutlet weak var buttonQ3: CustomButton!

    //Global Variables
    var painLevelVal:NSNumber?
    var affectSleepVal:NSNumber?
    var affectActivityVal:NSNumber?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // init data
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ValueChanged(sender: AnyObject) {
        sliderQ1.value = roundf(sender.value)
        labelQ1.text = NSString(format: "%.0f", sliderQ1.value) as String
        painLevelVal = roundf(sender.value)
    }

    @IBAction func buttonQ2_Clicked(sender: AnyObject) {

        let button2Popup = UIAlertController(title: "Headache Pain", message: "Choose one", preferredStyle: .Alert)
        let oneAction = UIAlertAction(title: "Not at all", style: .Default) { (_) in
            self.buttonQ2.setTitle("Not at all", forState: UIControlState.Normal)
            self.affectSleepVal = 0
        }
        let twoAction = UIAlertAction(title: "A little", style: .Default) { (_) in
            self.buttonQ2.setTitle("A little", forState: UIControlState.Normal)
            self.affectSleepVal = 1
        }
        let threeAction = UIAlertAction(title: "A lot", style: .Default) { (_) in
            self.buttonQ2.setTitle("A lot", forState: UIControlState.Normal)
            self.affectSleepVal = 2
        }
        button2Popup.addAction(oneAction)
        button2Popup.addAction(twoAction)
        button2Popup.addAction(threeAction)
        self.presentViewController(button2Popup, animated: true) {
        }

    }

    @IBAction func buttonQ3_Clicked(sender: AnyObject) {
        let button3Popup = UIAlertController(title: "Headache Pain", message: "Choose one", preferredStyle: .Alert)
        let oneAction = UIAlertAction(title: "Not at all", style: .Default) { (_) in
            self.buttonQ3.setTitle("Not at all", forState: UIControlState.Normal)
            self.affectActivityVal = 0
        }
        let twoAction = UIAlertAction(title: "A little", style: .Default) { (_) in
            self.buttonQ3.setTitle("A little", forState: UIControlState.Normal)
            self.affectActivityVal = 1
        }
        let threeAction = UIAlertAction(title: "A lot", style: .Default) { (_) in
            self.buttonQ3.setTitle("A lot", forState: UIControlState.Normal)
            self.affectActivityVal = 2
        }
        button3Popup.addAction(oneAction)
        button3Popup.addAction(twoAction)
        button3Popup.addAction(threeAction)
        self.presentViewController(button3Popup, animated: true) {
        }

    }
    @IBAction func NextBN(sender: UIButton) {
        
        if let trackerResponse = dataMgr?.getTrackerResponse(NSDate())
        {
       dataMgr?.saveTrackerResponse(NSDate(), hadHeadache: trackerResponse.hadHeadache, painLevel: painLevelVal!, affectSleep: affectSleepVal!, affectActivity: affectActivityVal!, painReasons: trackerResponse.painReasons, helpfulContent: trackerResponse.helpfulContent)
        }
        
    }

    // MARK: - Table view data source
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
