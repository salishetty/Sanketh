//
//  PinViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 7/27/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class PinViewController: UIViewController,ValidationDelegate, UITextFieldDelegate

{

    
    
    
    @IBOutlet weak var pinTF: UITextField!
    var dataMgr: DataManager?  // initialized in viewDidLoad
    var serviceMgr: ServiceManager?
    let validator = Validator()
    
    @IBOutlet weak var authErrorView: UIView!
    
    @IBOutlet weak var PinErrorLB: UILabel!
    
    @IBOutlet weak var authErrorLB: UILabel!
    
    @IBOutlet weak var UserLB: UILabel!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        
        // init data and service managers
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        serviceMgr = ServiceManager(objContext:manObjContext)
        
        
        UserLB.text = "Hi, " + AppContext.firstName
        
        // Do any additional setup after loading the view.
        //Error Validation
        validator.styleTransformers(success:{ (validationRule) -> Void in
            println("here")
            // clear error label
            validationRule.errorLabel?.hidden = true
            validationRule.errorLabel?.text = ""
            validationRule.textField.layer.borderColor = UIColor.darkGrayColor().CGColor
            validationRule.textField.layer.borderWidth = 0.5
            validationRule.textField.borderStyle = UITextBorderStyle.RoundedRect
            validationRule.textField.layer.cornerRadius = 5.0
            
            }, error:{ (validationError) -> Void in
                println("error")
                validationError.errorLabel?.hidden = false
                validationError.errorLabel?.text = validationError.errorMessage
                validationError.textField.layer.borderColor = UIColor.redColor().CGColor
                validationError.textField.layer.borderWidth = 1.0
                validationError.textField.borderStyle = UITextBorderStyle.RoundedRect
                validationError.textField.layer.cornerRadius = 5.0
        })
        
        validator.registerField(pinTF, errorLabel: PinErrorLB, rules: [RequiredRule(), PinRule()])
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
       @IBAction func Login(sender: UIButton) {
        println("Validating Pin...")
        validator.validate(self)
    }

    func validationSuccessful() {
        println("Validation Success!")
        let pin = pinTF.text
        let token:String = CryptoUtility().generateSecurityToken() as String
       
        //Get login Url
        var theURL:String = AppContext.svcUrl + "Login"
        
        if AppContext.hasConnectivity() {
            
            
            serviceMgr?.Login(["username":AppContext.membershipUserID, "pin":pin, "token":token], url: theURL, postCompleted: { (jsonData: NSDictionary?)->() in
                
                if let parseJSON = jsonData {
                    var status = parseJSON["Status"] as? Int
                    if(status == 1)
                    {
                            self.dataMgr?.saveMetaData(MetaDataKeys.LoginStatus, value: LoginStatus.LoggedIn, isSecured: true)
                            AppContext.loginStatus = LoginStatus.LoggedIn
                            self.loadViewController("TabView")
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
            println("Check network connection")
            self.authErrorLB.text = "Check network connection"
            self.authErrorView.addSubview(self.authErrorLB)
            self.authErrorView.hidden = false
        }
        
    }
    
    func validationFailed(errors:[UITextField:ValidationError]) {
        println("Validation FAILED!")
    }

    @IBAction func dismissKeyboard(sender: AnyObject) {
        self.view.endEditing(true)
    }

}
