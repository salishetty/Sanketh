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
        println("Validating Pin...")
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
        validator.registerField(nameTF, errorLabel: errorLB, rules: [RequiredRule(), RequiredRule()])
     }
    
    func validationSuccessful() {
            println("Validation Success!")
            self.dataMgr?.saveMetaData(MetaDataKeys.FirstName, value: self.nameTF.text, isSecured: true)
        }


    func validationFailed(errors:[UITextField:ValidationError]) {
        println("Validation FAILED!")
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
