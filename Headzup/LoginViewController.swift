//
//  LoginViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 7/21/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    //Text Fields
    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var pinTF: UITextField!
    
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    @IBOutlet weak var authErrorView: UIView!
    @IBOutlet weak var authErrorLB: UILabel!
    var dataMgr: DataManager?  // initialized in viewDidLoad
    var serviceMgr: ServiceManager?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init data and service managers
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        serviceMgr = ServiceManager(objContext:manObjContext)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func Login(sender: UIButton) {
        let pin = pinTF.text
        var phoneNumber:String = phoneNumberTF.text
        let token:String = CryptoUtility().generateSecurityToken() as String
        phoneNumber = phoneNumberTF.text
         //Get login Url
        var theURL:String = AppContext.svcUrl + "Login" 
        
        if AppContext.hasConnectivity() {

            serviceMgr?.Login(["username":phoneNumber, "pin":pin, "token":token], url: theURL, postCompleted: { (jsonData: NSDictionary?)->() in

                if let parseJSON = jsonData {
                    var status = parseJSON["Status"] as? Int
                    if(status == 1)
                    {
                        var memberhipUserID = parseJSON["MembershipUserID"] as? String
                        // update cache and local db
                        if AppContext.loginStatus == "" {

                            self.dataMgr?.saveMetaData(MetaDataKeys.FirstName, value: self.firstNameTF.text, isSecured: true)
                            
                            AppContext.firstName = self.firstNameTF.text
                            self.dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedIn, isSecured: true)
                            
                            AppContext.loginStatus = LoginStatus.LoggedIn
                            
                            self.dataMgr?.saveMetaData(MetaDataKeys.MembershipUserID, value: memberhipUserID!, isSecured: true)
                            AppContext.membershipUserID = memberhipUserID!
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
                    
                }
            })
        }
        else
        {
            println("No network connection")
             //feedbackLB.text = "Wrong credential, try again"
          }

    }

    @IBAction func dismissKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
    }
}
