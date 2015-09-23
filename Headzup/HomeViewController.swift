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
        let uInfo = AppContext.getUserInfo()
        let membershipUserID = uInfo.membershipUserID
        //Synch Favorites - Strategies
        var dict = Dictionary<String, String>()
        var responseItemsArray = [String:Dictionary<String, String>]()
        var objectID:String?
        let gHelper = GeneralHelper()
        let responsesTobeSynched:[AboutMeResponse] = dataMgr!.getResponsesToBeSynched()!
        let responsesTobeDeleted:[AboutMeResponse] = dataMgr!.getResponsesToBeDeleted()!
        if responsesTobeSynched.count > 0
        {
            var index:Int32 = 0
            for responseItem in responsesTobeSynched
            {
                print("AboutMeResponse Items: \(responseItem.questionID): \(responseItem.responseValue):\((responseItem.dateAdded))")
                
                let responseItems = ResponseItems(membershipUserId: membershipUserID, questionID: responseItem.questionID, responseValue: responseItem.responseValue, dateAdded: gHelper.convertDateToString(responseItem.dateAdded))
                
                dict = gHelper.responseItemsToDictionary(responseItems)
                responseItemsArray["ResponseItem"+String(index)] = dict
                //Abebe have a look
                //let lastComponent = responseItem.objectID.URIRepresentation().absoluteString.lastPathComponent
                let lastComponent = responseItem.objectID.URIRepresentation().absoluteString
                //Integer part of objectID
                objectID = lastComponent.substringFromIndex(lastComponent.startIndex.advancedBy(1))
                //update index
                index++
            }
        }
        let theURL:String =  AppContext.svcUrl + "SynchAboutMeResponse"
        
        if(responseItemsArray.count > 0)
        {
            serviceMgr?.synchAboutMeResponse(responseItemsArray , url: theURL, postCompleted: { (jsonData: NSDictionary?)->() in
                
                if let parseJSON = jsonData {
                    let status = parseJSON["Status"] as? Int
                    if(status == 1)
                    {
                        let synchDate = NSDate()
                        //if successful, save the last objectID to MetaData
                        //self.dataMgr?.saveMetaData("AboutMeResponseID", value: objectID!, isSecured: true)
                        self.dataMgr?.saveMetaData("SynchResponseDate", value: gHelper.convertDateToString(synchDate), isSecured: true)
                        //var responseToBeDeleted = Array(Set(responses).subtract(mostRecentResponse))
                        //Delete all synched AboutMe responses
                        for (_, response) in responsesTobeDeleted.enumerate()
                        {
                            print("AboutMe reponses: \(response.questionID): \(response.responseValue):,\(response.dateAdded)")
                            self.dataMgr?.deleteAboutMeResponse(response)
                        }
                        
                        print("About Me Response synchronized Successfully")
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
