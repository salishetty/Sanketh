//
//  HAReasonTableViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 10/20/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class HAReasonTableViewController: UITableViewController {

    var dataMgr: DataManager?
    var questionTextArray: [String] = [TrackerResponseQuestions.TQText_1, TrackerResponseQuestions.TQText_2, TrackerResponseQuestions.TQText_3, TrackerResponseQuestions.TQText_4, TrackerResponseQuestions.TQText_5, TrackerResponseQuestions.TQText_6, TrackerResponseQuestions.TQText_7, TrackerResponseQuestions.TQText_8, TrackerResponseQuestions.TQText_9, TrackerResponseQuestions.TQText_10, TrackerResponseQuestions.TQText_11, TrackerResponseQuestions.TQText_12, TrackerResponseQuestions.TQText_13, TrackerResponseQuestions.TQText_14]
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
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CauseOfPainCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return questionTextArray.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CauseOfPainCell", forIndexPath: indexPath)

        // Configure the cell...
        return QuestionHelper.PopulateMutiSelectTrackerQuestions(indexPath, cell: cell, dataMgr: dataMgr!)!
        //return cell
    }

    var responseValueArray:[String] = []
    var responseValue: String = ""
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        print("label: \(indexPath.row)")
        //Put the values in Array
        var responseValueArray = responseValue.componentsSeparatedByString(",")
        //get the value of selected Response
        let selectedResponseValue = String(indexPath.row)
        //If the selected response is in the array - remove it - Deselect!
        if responseValueArray.filter({ srValue in srValue == selectedResponseValue }).count > 0 {
            responseValueArray = responseValueArray.filter(notEqual(selectedResponseValue))
            
            //var newResponseValue: String?
            for var i = 0; i < responseValueArray.count; i++ {
                if i < responseValueArray.count - 1
                {
                    responseValue += responseValueArray[i] + ","
                }
                else
                {
                    responseValue += responseValueArray[i]
                }
            }
            cell!.accessoryType = UITableViewCellAccessoryType.None
        }
        else
        {
            
            responseValue = responseValue + "," + String(indexPath.row)
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
        }

        
        
        
        
        cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
        //Remove the gray selection
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func notEqual<T: Equatable> (that:T) -> ((this:T) -> Bool) {
        return { (this:T) -> Bool in return this != that }
    }


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
