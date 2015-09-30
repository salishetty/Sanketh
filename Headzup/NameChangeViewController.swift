//
//  NameChangeViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 9/15/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import CoreData

class NameChangeViewController: UIViewController, ValidationDelegate {

    @IBOutlet weak var errorLB: UILabel!
    
    @IBOutlet weak var nameTF: UITextField!
    var dataMgr: DataManager?
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DoneBarButton(sender: AnyObject) {
        print("Validating Pin...")
        validator.validate(self)
        
    }
    
    func baseLoad()
    {
        // init data and service managers
        let theAppDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manObjContext:NSManagedObjectContext = theAppDelegate.managedObjectContext!
        dataMgr = DataManager(objContext: manObjContext)
        
        
        //Show user Name on screen
        let firstName =  dataMgr!.getMetaDataValue(MetaDataKeys.FirstName)
        AppContext.firstName = firstName
        nameTF.text = firstName
       
        // Do any additional setup after loading the view.
        //Validate if Name/nickname is provided
        let validationHelper = ValidationHelper(validator: validator)
        validationHelper.validateName(nameTF, errorLB: errorLB)
     }
    
    func validationSuccessful() {
            print("Validation Success!")
            self.dataMgr?.saveMetaData(MetaDataKeys.FirstName, value: self.nameTF.text!, isSecured: true)
            //navigate back to Account tab
            self.loadViewController("TabView",tabIndex:4)
        }


    func validationFailed(errors:[UITextField:ValidationError]) {
        print("Validation FAILED!")
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
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
