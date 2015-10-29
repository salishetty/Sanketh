//
//  EffectivenessTableViewController.swift
//  Headzup
//
//  Created by Abebe Woreta on 10/28/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class EffectivenessTableViewController: UITableViewController {

    var dataMgr: DataManager?
    var strategiesArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // init data manager
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        
        if AppContext.strategies.count > 0
        {
            self.strategiesArray = AppContext.strategies
        }
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
        return strategiesArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EffectivenessCell", forIndexPath: indexPath)
        let text = strategiesArray[indexPath.row]
        // Configure the cell...
        return QuestionHelper.PopulateMutiSelectEffectivenessTrackerQuestions(indexPath, cell: cell, text: text, dataMgr: dataMgr!)!
        //return cell
    }

    var responseValueArray:[String] = []
    var responseValue: String = ""
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        var newResponseValue: String = ""
        responseValue = AppContext.painReasonsResponseValue
        //Put the values in Array
        if (responseValue != "")
        {
            responseValueArray = responseValue.componentsSeparatedByString(",")
            //get the value of selected Response
            let selectedResponseValue = String(indexPath.row)
            //If the selected response is in the array - remove it - Deselect!
            if responseValueArray.filter({ srValue in srValue == selectedResponseValue }).count > 0 {
                responseValueArray = responseValueArray.filter(notEqual(selectedResponseValue))
                
                for var i = 0; i < responseValueArray.count; i++ {
                    if i < responseValueArray.count - 1
                    {
                        newResponseValue += responseValueArray[i] + ","
                    }
                    else
                    {
                        newResponseValue += responseValueArray[i]
                    }
                }
                cell!.accessoryType = UITableViewCellAccessoryType.None
            }
            else
            {
                newResponseValue = responseValue + "," + String(indexPath.row)
                cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        }
        else
        {
            newResponseValue = String(indexPath.row)
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        responseValue = newResponseValue
        AppContext.painReasonsResponseValue = responseValue
        print("Response Value\(newResponseValue)")
        //Remove the gray selection
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func notEqual<T: Equatable> (that:T) -> ((this:T) -> Bool) {
        return { (this:T) -> Bool in return this != that }
    }
    
    func getResponseValue() -> String
    {
        return responseValue
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
