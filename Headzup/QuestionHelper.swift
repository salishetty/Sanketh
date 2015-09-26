//
//  QuestionHelper.swift
//  Headzup
//
//  Created by Abebe Woreta on 9/26/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation
import UIKit

public class QuestionHelper
{
    public static func SaveResponse(questionID:String, uiSC:UISegmentedControl, dataMgr:DataManager)
    {
        var responseValue:String = "0"
        let questionID:String = questionID
        switch uiSC.selectedSegmentIndex
        {
        case 0:
            responseValue = "0"
        case 1:
            responseValue = "1"
        default:
            break;
        }
        dataMgr.saveAboutMeReponse(questionID, dateAdded: NSDate(), responseValue: responseValue)
    }
}