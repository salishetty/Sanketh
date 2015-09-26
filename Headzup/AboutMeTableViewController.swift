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
        let questionID:String = AboutMeResponseQuestionCode.AMQ_1
        QuestionHelper.SaveResponse(questionID, uiSC: AMQ_1SC, dataMgr: dataMgr!)
    }
    
    @IBAction func AMQ_2SCIndexChanged(sender: UISegmentedControl) {
        let questionID:String = AboutMeResponseQuestionCode.AMQ_2
        QuestionHelper.SaveResponse(questionID, uiSC: AMQ_2SC, dataMgr: dataMgr!)
    }
    
    @IBAction func AMQ_3SCIndexChanged(sender: UISegmentedControl) {
        let questionID:String = AboutMeResponseQuestionCode.AMQ_3
        QuestionHelper.SaveResponse(questionID, uiSC: AMQ_3SC, dataMgr: dataMgr!)
    }
    
    @IBAction func AMQ_4SCIndexChanged(sender: UISegmentedControl) {
        let questionID:String = AboutMeResponseQuestionCode.AMQ_4
        QuestionHelper.SaveResponse(questionID, uiSC: AMQ_4SC, dataMgr: dataMgr!)
    }
    
    @IBAction func AMQ_5SCIndexChanged(sender: UISegmentedControl) {
        let questionID:String = AboutMeResponseQuestionCode.AMQ_5
        QuestionHelper.SaveResponse(questionID, uiSC: AMQ_5SC, dataMgr: dataMgr!)
    }
    
    @IBAction func AMQ_6SSCIndexChanged(sender: UISegmentedControl) {
        let questionID:String = AboutMeResponseQuestionCode.AMQ_6
        QuestionHelper.SaveResponse(questionID, uiSC: AMQ_6SC, dataMgr: dataMgr!)
    }
    
    @IBAction func AMQ_7SCIndexChanged(sender: UISegmentedControl) {
        let questionID:String = AboutMeResponseQuestionCode.AMQ_7
        QuestionHelper.SaveResponse(questionID, uiSC: AMQ_7SC, dataMgr: dataMgr!)
    }
    
    @IBAction func AMQ_8SCIndexChanged(sender: UISegmentedControl) {
        let questionID:String = AboutMeResponseQuestionCode.AMQ_8
        QuestionHelper.SaveResponse(questionID, uiSC: AMQ_8SC, dataMgr: dataMgr!)
    }
    
    @IBAction func AMQ_9SCIndexChanged(sender: UISegmentedControl) {
        let questionID:String = AboutMeResponseQuestionCode.AMQ_9
        QuestionHelper.SaveResponse(questionID, uiSC: AMQ_9SC, dataMgr: dataMgr!)
    }
    
    @IBAction func AMQ_10SCIndexChanged(sender: UISegmentedControl) {
        let questionID:String = AboutMeResponseQuestionCode.AMQ_10
        QuestionHelper.SaveResponse(questionID, uiSC: AMQ_10SC, dataMgr: dataMgr!)
    }
    func LoadYesNoQuestions()
    {
        let responses:[AboutMeResponse] = dataMgr!.getMostRecentAboutMeResponses()!
        for response : AboutMeResponse in responses
        {
            switch(response.questionID)
            {
                case AboutMeResponseQuestionCode.AMQ_1:
                    AMQ_1SC.selectedSegmentIndex = Int(response.responseValue)!
                case AboutMeResponseQuestionCode.AMQ_2:
                    AMQ_2SC.selectedSegmentIndex = Int(response.responseValue)!
                case AboutMeResponseQuestionCode.AMQ_3:
                    AMQ_3SC.selectedSegmentIndex = Int(response.responseValue)!
                case AboutMeResponseQuestionCode.AMQ_4:
                    AMQ_4SC.selectedSegmentIndex = Int(response.responseValue)!
                case AboutMeResponseQuestionCode.AMQ_5:
                    AMQ_5SC.selectedSegmentIndex = Int(response.responseValue)!
                case AboutMeResponseQuestionCode.AMQ_6:
                    AMQ_6SC.selectedSegmentIndex = Int(response.responseValue)!
                case AboutMeResponseQuestionCode.AMQ_7:
                    AMQ_7SC.selectedSegmentIndex = Int(response.responseValue)!
                case AboutMeResponseQuestionCode.AMQ_8:
                    AMQ_8SC.selectedSegmentIndex = Int(response.responseValue)!
                case AboutMeResponseQuestionCode.AMQ_9:
                    AMQ_9SC.selectedSegmentIndex = Int(response.responseValue)!
                case AboutMeResponseQuestionCode.AMQ_10:
                    AMQ_10SC.selectedSegmentIndex = Int(response.responseValue)!
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
