//
//  ValidationHelper.swift
//  Headzup
//
//  Created by Abebe Woreta on 9/25/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation
import UIKit

public class ValidationHelper
{
    var validator:Validator
    init (validator:Validator)
    {
        self.validator = validator
    }
    public func ApplyStyle()
    {
        
        //Error Validation
        validator.styleTransformers(success:{ (validationRule) -> Void in
            print("here")
            // clear error label
            validationRule.errorLabel?.hidden = true
            validationRule.errorLabel?.text = ""
            validationRule.textField.layer.borderColor = UIColor.darkGrayColor().CGColor
            validationRule.textField.layer.borderWidth = 0.5
            validationRule.textField.borderStyle = UITextBorderStyle.RoundedRect
            validationRule.textField.layer.cornerRadius = 5.0
            
            }, error:{ (validationError) -> Void in
                print("error")
                validationError.errorLabel?.hidden = false
                validationError.errorLabel?.text = validationError.errorMessage
                validationError.textField.layer.borderColor = UIColor.redColor().CGColor
                validationError.textField.layer.borderWidth = 1.0
                validationError.textField.borderStyle = UITextBorderStyle.RoundedRect
                validationError.textField.layer.cornerRadius = 5.0
        })

    }
    public func validateLoginCredential(firstName:UITextField, firstNameError:UILabel, pin:UITextField, pinError:UILabel, phoneNumber:UITextField, phoneNumberError:UILabel)
    {
        ApplyStyle()
        validator.registerField(firstName, errorLabel: firstNameError , rules: [RequiredRule(), RequiredRule()])
        validator.registerField(pin, errorLabel: pinError, rules: [RequiredRule(), PinRule()])
        validator.registerField(phoneNumber, errorLabel: phoneNumberError, rules: [RequiredRule(), MinLengthRule(length: 10,message:ValidationMessage.PHONE_NUMBER_VALIDATOR_MESSAGE) ,PhoneRule()])
    }
    public func validatePin(pin:UITextField, pinError:UILabel)
    {
        ApplyStyle()
        validator.registerField(pin, errorLabel: pinError, rules: [RequiredRule(), PinRule()])
    }
    public func validateName(name:UITextField, errorLB:UILabel)
    {
        ApplyStyle()
        validator.registerField(name, errorLabel: errorLB, rules: [RequiredRule(), RequiredRule()])
    }
}
public struct ValidationMessage
{
    public static let NETWORK_CONNECTION_ERROR_MESSAGE = "Check network connection."
    public static let DISABLED_USER_MESSAGE = "There has been a change with your access to the Headzup app. Please call us at <xxx-xxxxxxx> or email us at <xxxxxxxxxxx@xxx.com>."
    public static let INVALID_CREDENTIAL_MESSAGE = "The PIN and/or Phone Number entered doesn't match records."
    public static let INVALID_PIN_MESSAGE = "PIN doesn't match this phone number."
    public static let PHONE_NUMBER_VALIDATOR_MESSAGE = "Phone Number must be 10 digits long"
}
