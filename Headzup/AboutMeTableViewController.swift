//
//  AboutMeTableViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/8/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit

class AboutMeTableViewController: UITableViewController {

    @IBOutlet weak var PreventionSubView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        PreventionSubView.layer.cornerRadius = 12.0
        PreventionSubView.layer.borderColor = UIColor(netHex:0x2387CD).CGColor
        PreventionSubView.layer.borderWidth = 0.5
        PreventionSubView.clipsToBounds = true

        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SeclectionChange(sender: AnyObject) {
    }
    
    override func  tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
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
//      override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
////       let cell = tableView.dequeueReusableCellWithIdentifier("SubTable", forIndexPath: indexPath) as! UITableViewCell
////       return cell
//        if (indexPath.row == 10)
//        {
//        var cell:SubTableCell? = tableView.dequeueReusableCellWithIdentifier("SubTable") as?  SubTableCell
//        if(cell == nil)
//        {
//            cell = SubTableCell(style: UITableViewCellStyle.Default, reuseIdentifier: "SubTable")
//        }
//        cell?.dataArr = ["subMenu->1","subMenu->2","subMenu->3","subMenu->4","subMenu->5"]
//        return cell!
//        }
//        else
//        {
//            var cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
//            return cell
//        }
//        
//    }
 

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
