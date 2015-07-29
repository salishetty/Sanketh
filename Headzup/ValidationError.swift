//
//  ValidationError.swift
//  Headzup
//
//  Created by Abebe Woreta on 7/28/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import UIKit

public class ValidationError {
    public let textField:UITextField
    public var errorLabel:UILabel?
    public let errorMessage:String
    
    public init(textField:UITextField, error:String){
        self.textField = textField
        self.errorMessage = error
    }
    
    public init(textField:UITextField, errorLabel:UILabel?, error:String){
        self.textField = textField
        self.errorLabel = errorLabel
        self.errorMessage = error
    }
}
