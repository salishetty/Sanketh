//
//  AboutMeTableViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/8/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class AboutMeTableViewController: UITableViewController {

    @IBOutlet weak var PreventionSubView: UIView!
    var dataMgr: DataManager?
    var serviceMgr:ServiceManager?
    override func viewDidLoad() {
        super.viewDidLoad()

        PreventionSubView.layer.cornerRadius = 12.0
        PreventionSubView.layer.borderColor = UIColor(netHex:0x2387CD).CGColor
        PreventionSubView.layer.borderWidth = 0.5
        PreventionSubView.clipsToBounds = true

        // init data
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        serviceMgr = ServiceManager(objContext:manObjContext)
        //Load Responses to Yes-No Questions
        LoadYesNoQuestions()
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
    //SEGMENTED CONTROLS
    
    @IBOutlet weak var AMQ_1SC: UISegmentedControl!
    @IBOutlet weak var AMQ_2SC: UISegmentedControl!
    @IBOutlet weak var AMQ_3SC: UISegmentedControl!
    @IBOutlet weak var AMQ_4SC: UISegmentedControl!
    @IBOutlet weak var AMQ_5SC: UISegmentedControl!
    @IBOutlet weak var AMQ_6SC: UISegmentedControl!
    @IBOutlet weak var AMQ_7SC: UISegmentedControl!
    @IBOutlet weak var AMQ_8SC: UISegmentedControl!
    @IBOutlet weak var AMQ_9SC: UISegmentedControl!
    @IBOutlet weak var AMQ_10SC: UISegmentedControl!
    
    @IBAction func AMQ_1SCIndexChanged(sender: UISegmentedControl) {
        var responseValue:String = "0"
        var questionID:String = "AMQ_1"
        switch AMQ_1SC.selectedSegmentIndex
        {
        case 0:
            responseValue = "0"
        case 1:
            responseValue = "1"
        default:
            break; 
        }
        dataMgr?.saveAboutMeReponse(questionID, dateAdded: NSDate(), responseValue: responseValue)
    }
    
    @IBAction func AMQ_2SCIndexChanged(sender: UISegmentedControl) {
        var responseValue:String = "0"
        var questionID:String = "AMQ_2"
        switch AMQ_2SC.selectedSegmentIndex
        {
        case 0:
            responseValue = "0"
        case 1:
            responseValue = "1"
        default:
            break;
        }
        dataMgr?.saveAboutMeReponse(questionID, dateAdded: NSDate(), responseValue: responseValue)
    }
    
    @IBAction func AMQ_3SCIndexChanged(sender: UISegmentedControl) {
        var responseValue:String = "0"
        var questionID:String = "AMQ_3"
        switch AMQ_3SC.selectedSegmentIndex
        {
        case 0:
            responseValue = "0"
        case 1:
            responseValue = "1"
        default:
            break;
        }
        dataMgr?.saveAboutMeReponse(questionID, dateAdded: NSDate(), responseValue: responseValue)
    }
    
    @IBAction func AMQ_4SCIndexChanged(sender: UISegmentedControl) {
        var responseValue:String = "0"
        var questionID:String = "AMQ_4"
        switch AMQ_4SC.selectedSegmentIndex
        {
        case 0:
            responseValue = "0"
        case 1:
            responseValue = "1"
        default:
            break;
        }
        dataMgr?.saveAboutMeReponse(questionID, dateAdded: NSDate(), responseValue: responseValue)
    }
    
    @IBAction func AMQ_5SCIndexChanged(sender: UISegmentedControl) {
        var responseValue:String = "0"
        var questionID:String = "AMQ_5"
        switch AMQ_5SC.selectedSegmentIndex
        {
        case 0:
            responseValue = "0"
        case 1:
            responseValue = "1"
        default:
            break;
        }
        dataMgr?.saveAboutMeReponse(questionID, dateAdded: NSDate(), responseValue: responseValue)
    }
    
    @IBAction func AMQ_6SSCIndexChanged(sender: UISegmentedControl) {
        var responseValue:String = "0"
        var questionID:String = "AMQ_6"
        switch AMQ_6SC.selectedSegmentIndex
        {
        case 0:
            responseValue = "0"
        case 1:
            responseValue = "1"
        default:
            break;
        }
        dataMgr?.saveAboutMeReponse(questionID, dateAdded: NSDate(), responseValue: responseValue)
    }
    
    @IBAction func AMQ_7SCIndexChanged(sender: UISegmentedControl) {
        var responseValue:String = "0"
        var questionID:String = "AMQ_7"
        switch AMQ_7SC.selectedSegmentIndex
        {
        case 0:
            responseValue = "0"
        case 1:
            responseValue = "1"
        default:
            break;
        }
        dataMgr?.saveAboutMeReponse(questionID, dateAdded: NSDate(), responseValue: responseValue)
    }
    
    @IBAction func AMQ_8SCIndexChanged(sender: UISegmentedControl) {
        var responseValue:String = "0"
        var questionID:String = "AMQ_8"
        switch AMQ_8SC.selectedSegmentIndex
        {
        case 0:
            responseValue = "0"
        case 1:
            responseValue = "1"
        default:
            break;
        }
        dataMgr?.saveAboutMeReponse(questionID, dateAdded: NSDate(), responseValue: responseValue)
    }
    
    @IBAction func AMQ_9SCIndexChanged(sender: UISegmentedControl) {
        var responseValue:String = "0"
        var questionID:String = "AMQ_9"
        switch AMQ_9SC.selectedSegmentIndex
        {
        case 0:
            responseValue = "0"
        case 1:
            responseValue = "1"
        default:
            break;
        }
        dataMgr?.saveAboutMeReponse(questionID, dateAdded: NSDate(), responseValue: responseValue)
    }
    
    @IBAction func AMQ_10SCIndexChanged(sender: UISegmentedControl) {
        var responseValue:String = "0"
        var questionID:String = "AMQ_10"
        switch AMQ_10SC.selectedSegmentIndex
        {
        case 0:
            responseValue = "0"
        case 1:
            responseValue = "1"
        default:
            break;
        }
        dataMgr?.saveAboutMeReponse(questionID, dateAdded: NSDate(), responseValue: responseValue)
    }
    func LoadYesNoQuestions()
    {
        var responses:[AboutMeResponse] = dataMgr!.getAllAboutMeResponses()!
        for response : AboutMeResponse in responses
        {
            switch(response.questionID)
            {
                case "AMQ_1":
                    AMQ_1SC.selectedSegmentIndex = response.responseValue.toInt()!
                case "AMQ_2":
                    AMQ_2SC.selectedSegmentIndex = response.responseValue.toInt()!
                case "AMQ_3":
                    AMQ_3SC.selectedSegmentIndex = response.responseValue.toInt()!
                case "AMQ_4":
                    AMQ_4SC.selectedSegmentIndex = response.responseValue.toInt()!
                case "AMQ_5":
                    AMQ_5SC.selectedSegmentIndex = response.responseValue.toInt()!
                case "AMQ_6":
                    AMQ_6SC.selectedSegmentIndex = response.responseValue.toInt()!
                case "AMQ_7":
                    AMQ_7SC.selectedSegmentIndex = response.responseValue.toInt()!
                case "AMQ_8":
                    AMQ_8SC.selectedSegmentIndex = response.responseValue.toInt()!
                case "AMQ_9":
                    AMQ_9SC.selectedSegmentIndex = response.responseValue.toInt()!
                case "AMQ_10":
                    AMQ_10SC.selectedSegmentIndex = response.responseValue.toInt()!
                default:
                    break;
            }
        }
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
