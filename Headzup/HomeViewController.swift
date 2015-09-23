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
    var serviceMgr:ServiceManager?
    
    
    @IBOutlet weak var greetingLB: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // init data
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        serviceMgr = ServiceManager(objContext:manObjContext)
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
        SynchTailoringQuestions()
    }

    func SynchTailoringQuestions() {
        var uInfo = AppContext.getUserInfo()
        var membershipUserID = uInfo.membershipUserID
        //Synch Favorites - Strategies
        var dict = Dictionary<String, String>()
        var responseItemsArray = [String:Dictionary<String, String>]()
        var objectID:String?
        var gHelper = GeneralHelper()
        let responsesTobeSynched:[AboutMeResponse] = dataMgr!.getResponsesToBeSynched()!
        if responsesTobeSynched.count > 0
        {
            var index:Int32 = 0
            for responseItem in responsesTobeSynched
            {
                println("AboutMeResponse Items: \(responseItem.questionID): \(responseItem.responseValue):\((responseItem.dateAdded))")
                
                var responseItems = ResponseItems(membershipUserId: membershipUserID, questionID: responseItem.questionID, responseValue: responseItem.responseValue, dateAdded: gHelper.convertDateToString(responseItem.dateAdded))
                
                dict = gHelper.responseItemsToDictionary(responseItems)
                responseItemsArray["ResponseItem"+String(index)] = dict
                //update index
                index++
            }
        }
        var theURL:String =  AppContext.svcUrl + "SynchAboutMeResponse"
        
        if(responseItemsArray.count > 0)
        {
            serviceMgr?.synchAboutMeResponse(responseItemsArray , url: theURL, postCompleted: { (jsonData: NSDictionary?)->() in
                
                if let parseJSON = jsonData {
                    var status = parseJSON["Status"] as? Int
                    if(status == 1)
                    {
                        var synchDate = NSDate()
                        self.dataMgr?.saveMetaData("SynchResponseDate", value: gHelper.convertDateToString(synchDate), isSecured: true)
                         println("About Me Response synchronized Successfully")
                    }
                }
                
                }
            )
            // Do any additional setup after loading the view.
        }
        
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
