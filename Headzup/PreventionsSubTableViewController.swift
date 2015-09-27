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
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "PreventionCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        let abtMeResponse = dataMgr!.getAboutMeResponse("AMQ_11")
        print("response value; \(abtMeResponse?.responseValue)")
        var responseValue:String?
        var newResponseValue: String = ""
        if abtMeResponse != nil
        {
            responseValue = abtMeResponse!.responseValue
        }
        if cell!.selected == true
        {
            //cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            print("label: \(indexPath.row)")
            if (responseValue != nil && responseValue != "")
            {
                //Put the values in Array
                var responseValueArray:[String] = responseValue!.componentsSeparatedByString(",")
                //get the value of selected Response
                let selectedResponseValue = String(indexPath.row)
                //If the selected response is in the array - remove it - Deselect!
                if responseValueArray.filter({ srValue in srValue == selectedResponseValue }).count > 0 {
                    responseValueArray = responseValueArray.filter(notEqual(selectedResponseValue))
                    
                    //var newResponseValue: String?
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
                
                    newResponseValue = responseValue! + "," + String(indexPath.row)
                    cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
            }
            else
            {
                newResponseValue = String(indexPath.row)
                cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            dataMgr?.saveAboutMeReponse("AMQ_11", dateAdded: NSDate(), responseValue: newResponseValue)
        }
        else
        {
            cell!.accessoryType = UITableViewCellAccessoryType.None
        }
        //Remove the gray selection
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
    var QuestionTextArray: [String] = [AboutMeResponseQuestions.AMQText_1, AboutMeResponseQuestions.AMQText_2, AboutMeResponseQuestions.AMQText_3, AboutMeResponseQuestions.AMQText_4, AboutMeResponseQuestions.AMQText_5, AboutMeResponseQuestions.AMQText_6, AboutMeResponseQuestions.AMQText_7, AboutMeResponseQuestions.AMQText_8, AboutMeResponseQuestions.AMQText_9, AboutMeResponseQuestions.AMQText_10]
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PreventionCell", forIndexPath: indexPath) 
        cell.textLabel?.text = QuestionTextArray[indexPath.row]
        cell.textLabel?.textColor = UIColor(netHex:0x2387CD)
        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = NSTextAlignment.Left
        cell.textLabel?.font = UIFont.systemFontOfSize(15.0)
        cell.textLabel?.baselineAdjustment = UIBaselineAdjustment.AlignBaselines
        
        let abtMeResponse = dataMgr!.getAboutMeResponse("AMQ_11")
        var responseValue:String?
        var responseValueArray:[String]=[]
        if abtMeResponse != nil
        {
            responseValue = abtMeResponse!.responseValue
            responseValueArray = responseValue!.componentsSeparatedByString(",")
        }
        
        
        print("Index: \(indexPath.row)")
        
        if responseValueArray.contains(String(indexPath.row))
        {
            cell.accessoryType =  UITableViewCellAccessoryType.Checkmark
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    
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
