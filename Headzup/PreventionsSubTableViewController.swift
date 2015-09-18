//
//  PreventionsSubTableViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/16/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class PreventionsSubTableViewController: UITableViewController {
    
    var dataMgr: DataManager?
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        var abtMeResponse = dataMgr!.getAboutMeResponse("AMQ_11")
        println("response value; \(abtMeResponse?.responseValue)")
        var responseValue:String?
        var newResponseValue: String = ""
        if abtMeResponse != nil
        {
            responseValue = abtMeResponse!.responseValue
        }
        if cell!.selected == true
        {
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            println("label: \(indexPath.row)")
            if (responseValue != nil)
            {
                newResponseValue = responseValue! + "," + toString(indexPath.row)
            }
            else
            {
                newResponseValue = toString(indexPath.row)
            }
            dataMgr?.saveAboutMeReponse("AMQ_11", dateAdded: NSDate(), responseValue: newResponseValue)
        }
        else
        {
            cell!.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        var abtMeResponse = dataMgr!.getAboutMeResponse("AMQ_11")
        var responseValue:String?
        if abtMeResponse != nil
        {
            responseValue = abtMeResponse!.responseValue
        }
        var responseValueArray:[String] = responseValue!.componentsSeparatedByString(",")
        
        var selectedResponseValue = toString(indexPath.row)
        responseValueArray = responseValueArray.filter(notEqual(selectedResponseValue))
        
        var newResponseValue: String = ""
        for var i = 0; i < responseValueArray.count; i++ {
            newResponseValue += responseValueArray[i] + ","
        }
        
        dataMgr?.saveAboutMeReponse("AMQ_11", dateAdded: NSDate(), responseValue: newResponseValue)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if cell!.selected == true
        {
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else
        {
            cell!.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    func notEqual<T: Equatable> (that:T) -> ((this:T) -> Bool) {
        return { (this:T) -> Bool in return this != that }
    }
    
    /*
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0
    }
    */
    
    /*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("PreventionCell", forIndexPath: indexPath) as! UITableViewCell
    //let cell = tableView.cellForRowAtIndexPath(,indexPath)
    var abtMeResponse = dataMgr!.getAboutMeResponse("AMQ_11")
    var responseValue:String?
    if abtMeResponse != nil
    {
    responseValue = abtMeResponse!.responseValue
    }
    var responseValueArray:[String] = responseValue!.componentsSeparatedByString(",")
    
    for var i = 0; i < responseValueArray.count; i++ {
    if indexPath.row == responseValueArray[i].toInt()
    {
    cell.accessoryType =  UITableViewCellAccessoryType.Checkmark
    }
    else
    {
    cell.accessoryType = UITableViewCellAccessoryType.None
    }
    }
    // Configure the cell...
    
    return cell
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
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
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
