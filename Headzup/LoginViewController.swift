//
//  LoginViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 7/21/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController,  ValidationDelegate, UITextFieldDelegate  {

    //Text Fields
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var pinTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    //Error Labels
    
    @IBOutlet weak var firstNameErrorLB: UILabel!
    @IBOutlet weak var pinErrorLB: UILabel!
    @IBOutlet weak var phoneNumberLB: UILabel!
    @IBOutlet weak var authErrorView: UIView!
    @IBOutlet weak var authErrorLB: UILabel!
    var dataMgr: DataManager?  // initialized in viewDidLoad
    let validator = Validator()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberTF.delegate = self
        phoneNumberTF.text = "000-000-0000"
        phoneNumberTF.textColor =  UIColor.lightGrayColor()
        
        //Adding notification to
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "baseLoad", name:UIApplicationWillEnterForegroundNotification, object: nil)
        baseLoad()
    }

    func textFieldDidBeginEditing(textField: UITextField) {
           if phoneNumberTF.textColor == UIColor.lightGrayColor() {
            phoneNumberTF.text = nil
            phoneNumberTF.textColor = UIColor.blackColor()
        }
    }
    func textFieldDidEndEditing(textField: UITextField) {
             if phoneNumberTF.text!.isEmpty {
                phoneNumberTF.text = "000-000-0000"
                phoneNumberTF.textColor =  UIColor.lightGrayColor()

        }
    }
    func baseLoad()
    {
        
        // init data and service managers
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        
        //Validate User Credentials
        let validationHelper = ValidationHelper(validator: validator)
        validationHelper.validateLoginCredential(firstNameTF, firstNameError: firstNameErrorLB, pin: pinTF, pinError: pinErrorLB, phoneNumber: phoneNumberTF, phoneNumberError: phoneNumberLB)
        // Do any additional setup after loading the view.
        if(AppContext.hasConnectivity() == false)
        {
            dispatch_async(dispatch_get_main_queue()) {
                
                self.authErrorLB.text = ValidationMessage.NETWORK_CONNECTION_ERROR_MESSAGE
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func Login(sender: UIButton) {
        print("Validating...")
        validator.validate(self)
    }
    //ValidationDelegate Methods
    
    func validationSuccessful() {
        print("Validation Success!")
        
        self.dataMgr?.saveMetaData(MetaDataKeys.FirstName, value: self.firstNameTF.text!, isSecured: true)

        let pin = pinTF.text!.uppercaseString
        let phoneNumber:String = phoneNumberTF.text!
        if AppContext.hasConnectivity() {
            
            let serviceManager = ServiceManager()
            
            
           serviceManager.Login(["username":phoneNumber, "pin":pin],completion: { (jsonData: JSON?)->() in
                print(jsonData?.string)
                if let parseJSON:JSON = jsonData {
                    let status = parseJSON["Status"].stringValue
                    print("staus of login is\(status)")
                    
                    if(status == "1")
                    {
                            AppContext.firstName = self.firstNameTF.text!
                            self.dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedIn, isSecured: true)
                            
                            AppContext.loginStatus = LoginStatus.LoggedIn
                        
                            let memberhipUserID = parseJSON["MembershipUserID"].stringValue
                            self.dataMgr?.saveMetaData(MetaDataKeys.MembershipUserID, value: memberhipUserID, isSecured: true)
                            AppContext.membershipUserID = memberhipUserID                        
                            self.dataMgr?.saveUserActionLog(UserActions.Login, actionDateTime: NSDate(), contentID: "", comment: "Login", isSynched: false)
                        
                        //enable tracker notification
                        let date: NSDate = NSDate()
                        let cal: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
                        let fireDate: NSDate = cal.dateBySettingHour(8, minute: 0, second: 0, ofDate: date, options: NSCalendarOptions())!
                        NotificationHelper.EnableTrackerNotifcation(fireDate)
                        
                        self.loadViewController("TabView",tabIndex:0)
                    }
                    else if(status == "2")
                    {
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            self.authErrorLB.text = ValidationMessage.DISABLED_USER_MESSAGE
                            self.authErrorLB.numberOfLines = 0
                            self.authErrorView.addSubview(self.authErrorLB)
                            self.authErrorView.hidden = false
                            self.authErrorView.backgroundColor = UIColor.redColor()
                            self.authErrorView.layer.zPosition = 1
                        }
                    }
                    else
                    {
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            self.authErrorLB.text = ValidationMessage.INVALID_CREDENTIAL_MESSAGE
                            self.authErrorLB.numberOfLines = 0
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
            dispatch_async(dispatch_get_main_queue()) {
            print("Check network connection")
            self.authErrorLB.text = ValidationMessage.NETWORK_CONNECTION_ERROR_MESSAGE
            self.authErrorView.addSubview(self.authErrorLB)
            self.authErrorView.hidden = false
            }
        }
        
    }
    
   
    func validationFailed(errors: [UITextField : ValidationError]) {
        print("Validation failed")
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
