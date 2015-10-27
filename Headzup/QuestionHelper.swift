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
    public static func SaveSingleSelectResponse(questionID:String, uiSC:UISegmentedControl, dataMgr:DataManager)
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
    public static func SaveMultiSelectResponse(indexPath:NSIndexPath, cell:UITableViewCell?, dataMgr:DataManager)
    {
        let abtMeResponse = dataMgr.getAboutMeResponse(AboutMeResponseQuestionCode.AMQ_11)
        print("response value; \(abtMeResponse?.responseValue)")
        var responseValue:String?
        var newResponseValue: String = ""
        if abtMeResponse != nil
        {
            responseValue = abtMeResponse!.responseValue
        }

            //cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            print("label: \(indexPath.row)")
            if (responseValue != nil && responseValue != "")
            {
                //Put the values in Array
                var responseValueArray:[String] = responseValue!.componentsSeparatedByString(",")
                //get the value of selected Response
                let selectedResponseValue = String(indexPath.row)
                //If the selected response is in the array - remove it - Deselect!
                if responseValueArray.filter({ srValue in srValue == selectedResponseValue }).count > 0 {
                    responseValueArray = responseValueArray.filter(notEqual(selectedResponseValue))
                    
                    //var newResponseValue: String?
                    for var i = 0; i < responseValueArray.count; i++ {
                        if i < responseValueArray.count - 1
                        {
                            newResponseValue += responseValueArray[i] + ","
                        }
                        else
                        {
                            newResponseValue += responseValueArray[i]
                        }
                    }
                    cell!.accessoryType = UITableViewCellAccessoryType.None
                }
                else
                {
                    
                    newResponseValue = responseValue! + "," + String(indexPath.row)
                    cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
            }
            else
            {
                newResponseValue = String(indexPath.row)
                cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            dataMgr.saveAboutMeReponse(AboutMeResponseQuestionCode.AMQ_11, dateAdded: NSDate(), responseValue: newResponseValue)
     }
    
    static func notEqual<T: Equatable> (that:T) -> ((this:T) -> Bool) {
        return { (this:T) -> Bool in return this != that }
    }
    
    public static func PopulateMutiSelectQuestions(indexPath:NSIndexPath, cell:UITableViewCell?, dataMgr:DataManager) -> UITableViewCell?
    {
        var QuestionTextArray: [String] = [AboutMeResponseQuestions.AMQText_1, AboutMeResponseQuestions.AMQText_2, AboutMeResponseQuestions.AMQText_3, AboutMeResponseQuestions.AMQText_4, AboutMeResponseQuestions.AMQText_5, AboutMeResponseQuestions.AMQText_6, AboutMeResponseQuestions.AMQText_7, AboutMeResponseQuestions.AMQText_8, AboutMeResponseQuestions.AMQText_9, AboutMeResponseQuestions.AMQText_10]
        //Apply style to multi-select questions
        cell!.textLabel?.text = QuestionTextArray[indexPath.row]
        cell!.textLabel?.textColor = UIColor(netHex:0x2387CD)
        cell!.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell!.textLabel?.numberOfLines = 0
        cell!.textLabel?.textAlignment = NSTextAlignment.Left
        cell!.textLabel?.font = UIFont.systemFontOfSize(15.0)
        cell!.textLabel?.baselineAdjustment = UIBaselineAdjustment.AlignBaselines
        
        let abtMeResponse = dataMgr.getAboutMeResponse(AboutMeResponseQuestionCode.AMQ_11)
        var responseValue:String?
        var responseValueArray:[String]=[]
        if abtMeResponse != nil
        {
            responseValue = abtMeResponse!.responseValue
            responseValueArray = responseValue!.componentsSeparatedByString(",")
        }
        print("Index: \(indexPath.row)")
        
        if responseValueArray.contains(String(indexPath.row))
        {
            cell!.accessoryType =  UITableViewCellAccessoryType.Checkmark
        }
        else
        {
            cell!.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    public static func PopulateMutiSelectTrackerQuestions(indexPath:NSIndexPath, cell:UITableViewCell?, dataMgr:DataManager) -> UITableViewCell?
    {
        var QuestionTextArray: [String] = [TrackerResponseQuestions.TQText_1, TrackerResponseQuestions.TQText_2, TrackerResponseQuestions.TQText_3, TrackerResponseQuestions.TQText_4, TrackerResponseQuestions.TQText_5, TrackerResponseQuestions.TQText_6, TrackerResponseQuestions.TQText_7, TrackerResponseQuestions.TQText_8, TrackerResponseQuestions.TQText_9, TrackerResponseQuestions.TQText_10, TrackerResponseQuestions.TQText_11, TrackerResponseQuestions.TQText_12, TrackerResponseQuestions.TQText_13]
        //Apply style to multi-select questions
        cell!.textLabel?.text = QuestionTextArray[indexPath.row]
        cell!.textLabel?.textColor = UIColor(netHex:0x2387CD)
        cell!.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell!.textLabel?.numberOfLines = 0
        cell!.textLabel?.textAlignment = NSTextAlignment.Left
        cell!.textLabel?.font = UIFont.systemFontOfSize(15.0)
        cell!.textLabel?.baselineAdjustment = UIBaselineAdjustment.AlignBaselines
        return cell
    }
}