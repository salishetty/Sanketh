//
//  TrackerViewController.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 10/8/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import UIKit
import CVCalendar
class TrackerViewController: UIViewController,CVCalendarViewDelegate,CVCalendarMenuViewDelegate {

    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var monthLabel: UILabel!

    //Global Variable
    var shouldShowDaysOut = true
    var animationFinished = true


    override func viewDidLoad() {
        super.viewDidLoad()

        // Calendar delegate [Required]
        self.calendarView.calendarDelegate = self

        // Menu delegate [Required]
        self.menuView.menuViewDelegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
        calendarView.changeDaysOutShowingState(true)
    }


    @IBAction func TrackTodayClicked(sender: AnyObject) {
        //open tracker day

    }

    //Action
    @IBAction func loadPrevious(sender: AnyObject) {
        calendarView.loadPreviousView()
    }


    @IBAction func loadNext(sender: AnyObject) {
        calendarView.loadNextView()
    }


    //MonthLabel
    func presentedDateUpdated(date: CVDate) {
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .Center
            updatedMonthLabel.text = date.globalDescription //format of date
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center

            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransformMakeTranslation(0, offset)
            updatedMonthLabel.transform = CGAffineTransformMakeScale(1, 0.1)

            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransformMakeTranslation(0, -offset)
                self.monthLabel.transform = CGAffineTransformMakeScale(1, 0.1)
                self.monthLabel.alpha = 0

                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransformIdentity

                }) { _ in

                    self.animationFinished = true
                    self.monthLabel.frame = updatedMonthLabel.frame
                    self.monthLabel.text = updatedMonthLabel.text
                    self.monthLabel.transform = CGAffineTransformIdentity
                    self.monthLabel.alpha = 1
                    updatedMonthLabel.removeFromSuperview()
            }

            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }



    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .MonthView
    }

    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .Sunday
    }

    func shouldShowWeekdaysOut() -> Bool {
        return shouldShowDaysOut
    }

    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }

    func didSelectDayView(dayView: CVCalendarDayView) {
        let date = dayView.date
        print("\(calendarView.presentedDate.commonDescription) is selected! .\(date.globalDescription)")
    }



    //Dot Marker
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        let day = dayView.date.day
        let randomDay = Int(arc4random_uniform(31))
        if day == randomDay {
            return true
        }
        return false
        }

    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
//        //let day = dayView.date.day
//
//        let red = CGFloat(arc4random_uniform(600) / 255)
//        let green = CGFloat(arc4random_uniform(600) / 255)
//        let blue = CGFloat(arc4random_uniform(600) / 255)
//
//        let color = UIColor.greenColor()
//
//        let numberOfDots = 1 //Int(arc4random_uniform(3) + 1)
//        switch(numberOfDots) {
//        case 2:
//            return [color, color]
//        case 3:
//            return [color, color, color]
//        default:
//            return [color] // return 1 dot
//        }

        return [UIColor(netHex:0x78AC2D)]
    }

    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }


//    func dotMarker(moveOffsetOnDayView dayView: DayView) -> CGFloat {
//        return 2
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
