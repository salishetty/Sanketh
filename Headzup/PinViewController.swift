//
//  PinViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 7/27/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class PinViewController: UIViewController {

    
    
    
    var dataMgr: DataManager?  // initialized in viewDidLoad
    var serviceMgr: ServiceManager?
    let validator = Validator()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        
        // init data and service managers
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        serviceMgr = ServiceManager(objContext:manObjContext)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func validationSuccessful() {
        println("Validation Success!")
        let pin = pinTF.text
        let token:String = CryptoUtility().generateSecurityToken() as String
       
        //Get login Url
        var theURL:String = AppContext.svcUrl + "Login"
        
        if AppContext.hasConnectivity() {
            
                        
            
            
            serviceMgr?.Login(["MembershipUserID":AppContext.membershipUserID, "pin":pin, "token":token], url: theURL, postCompleted: { (jsonData: NSDictionary?)->() in
                
                if let parseJSON = jsonData {
                    var status = parseJSON["Status"] as? Int
                    if(status == 1)
                    {
                            self.dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedIn, isSecured: true)
                            AppContext.loginStatus = LoginStatus.LoggedIn
                    }
                        self.loadViewController("HomePageView")
                    }
                    else
                    {
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            self.authErrorLB.text = "Wrong credential, try again"
                            self.authErrorView.addSubview(self.authErrorLB)
                            self.authErrorView.hidden = false
                        }
                    }
            })
        }
            
        else
        {
            
            //feedbackLB.text = "Wrong credential, try again"
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
