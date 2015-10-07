//
//  PinViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 7/27/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON
class PinViewController: UIViewController,ValidationDelegate, UITextFieldDelegate
    
{
    
    
    
    
    @IBOutlet weak var pinTF: UITextField!
    var dataMgr: DataManager?  // initialized in viewDidLoad
    let validator = Validator()
    
    @IBOutlet weak var authErrorView: UIView!
    
    @IBOutlet weak var PinErrorLB: UILabel!
    
    @IBOutlet weak var authErrorLB: UILabel!
    
    @IBOutlet weak var UserLB: UILabel!
    
    internal var TabIndex:Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding notification to
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "baseLoad", name:UIApplicationWillEnterForegroundNotification, object: nil)
        
        // Do any additional setup after loading the view.
        baseLoad()
        
        
    }
    
    
    
    func baseLoad()
    {
        // init data and service managers
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        
        
        //log out user
        self.dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedOut, isSecured: true)
        AppContext.loginStatus = LoginStatus.LoggedOut

        
        
        //Show user Name on screen
        let username =  dataMgr!.getMetaDataValue(MetaDataKeys.FirstName)
        UserLB.text = "Hi, " + username
        AppContext.firstName = username
        
        // Do any additional setup after loading the view.
        //Validate User Pin
        let validationHelper = ValidationHelper(validator: validator)
        validationHelper.validatePin(pinTF, pinError: PinErrorLB)
        
        if(AppContext.hasConnectivity() == false)
        {
            dispatch_async(dispatch_get_main_queue()) {
                
                self.authErrorLB.text = "Check network connection."
                self.authErrorView.addSubview(self.authErrorLB)
                self.authErrorView.hidden = false
                self.authErrorView.backgroundColor = UIColor.orangeColor()
                self.authErrorView.layer.zPosition = 1
            }
            
        }
        else
        {
            self.authErrorView.hidden = true
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Login(sender: UIButton) {
        print("Validating Pin...")
        validator.validate(self)
    }
    
    func validationSuccessful() {
        print("Validation Success!")
        let pin = pinTF.text!.uppercaseString
        
        if AppContext.hasConnectivity() {
            let serviceManager = ServiceManager()
            serviceManager.Login(["username":AppContext.membershipUserID, "pin":pin], completion: { (jsonData: JSON?)->() in
                
                if let parseJSON = jsonData
                {
                    let status = parseJSON["Status"]
                    if(status == "1")
                    {
                        self.dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedIn, isSecured: true)
                        AppContext.loginStatus = LoginStatus.LoggedIn
                        self.dataMgr?.saveUserActionLog(UserActions.Login, actionDateTime: NSDate(), contentID: "", comment: "Login", isSynched: false)
                        if(AppContext.currentView == "HomeView")
                        {
                            self.loadViewController("TabView")
                        }
                        else
                        {
                            self.loadViewController("TabView", tabIndex: self.TabIndex)
                        }
                    }
                    else if(status == "2")
                    {
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            self.authErrorLB.text = ValidationMessage.DISABLED_USER_MESSAGE
                            self.authErrorView.addSubview(self.authErrorLB)
                            self.authErrorView.hidden = false
                            self.authErrorView.backgroundColor = UIColor.redColor()
                            self.authErrorView.layer.zPosition = 1
                        }
                    }
                    else
                    {
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            self.authErrorLB.text = ValidationMessage.INVALID_PIN_MESSAGE
                            self.authErrorView.addSubview(self.authErrorLB)
                            self.authErrorView.hidden = false
                            self.authErrorView.backgroundColor = UIColor.redColor()
                            self.authErrorView.layer.zPosition = 1
                        }
                    }
                }
                
            })
        }
        else
        {
            print("Check network connection")
            self.authErrorLB.text = ValidationMessage.NETWORK_CONNECTION_ERROR_MESSAGE
            self.authErrorView.addSubview(self.authErrorLB)
            self.authErrorView.hidden = false
        }
        
    }
    
    func validationFailed(errors:[UITextField:ValidationError]) {
        print("Validation FAILED!")
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
}
