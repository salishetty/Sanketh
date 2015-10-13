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

        //Change apperance from delegate
        self.calendarView.calendarAppearanceDelegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()

        //Removed days out of month
        calendarView.changeDaysOutShowingState(true)
        self.shouldShowDaysOut = false
    }


    @IBAction func TrackTodayClicked(sender: AnyObject) {
        print("\(calendarView.presentedDate.commonDescription) is selected!")
    }

    //Action
    @IBAction func loadPrevious(sender: AnyObject) {
        calendarView.loadPreviousView()
    }


    @IBAction func loadNext(sender: AnyObject) {
        calendarView.loadNextView()
    }


    func didSelectDayView(dayView: CVCalendarDayView) {
       //let date = dayView.date
       // print("\(calendarView.presentedDate.commonDescription) is selected! .\(date.globalDescription)")
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

    //Top Menu Settings: Font
    func dayOfWeekFont() -> UIFont {
        return UIFont (name: "Arial Rounded MT Bold", size: 15)!
    }
    //Top Menu Settings: Case
    func dayOfWeekTextUppercase() -> Bool {
        return false
    }
    //Top Menu Settings: color
    func dayOfWeekTextColor() -> UIColor {
        return UIColor(netHex:0x78AC2D)
    }


    //Calendar should show days out
    func shouldShowWeekdaysOut() -> Bool {
        return shouldShowDaysOut
    }

    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }

    //Dot Marker
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        let daysGoalCompleted = [1,2,4,8,13,16,19,22,23,25,28,29]
        guard let date = dayView.date else
        {
            return false
        }
        if daysGoalCompleted.contains((date.day)) {
            return true
        }
        return false
    }

    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        return [UIColor(netHex:0xB1E100)]
    }

    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }

    func dotMarker(moveOffsetOnDayView dayView: DayView) -> CGFloat {
        return 15
    }

    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 17
    }

    //Primary View :Head Ache view

    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.Circle)
        circleView.fillColor = .colorFromCode(0xD4A6FF)
        return circleView
    }

    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        let daysofHeadache = [7,9,11,17,19,22,15,28]
        guard let date = dayView.date else
        {
            return false
        }
        if daysofHeadache.contains((date.day)) {
            return true
        }
        return false
    }


    //Supplementary View : AKA No Head Ache
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        let π = M_PI

        let ringSpacing: CGFloat = 4.0 //3
        let ringInsetWidth: CGFloat = 1.0 //1.0
        let ringVerticalOffset: CGFloat = 1.0 //1.0
        var ringLayer: CAShapeLayer!
        let ringLineWidth: CGFloat = 3.0 //Ring Width
        let ringLineColour: UIColor = UIColor(netHex: 0xD4A6FF) //Ring Color

        let newView = UIView(frame: dayView.bounds)

        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
        let radius: CGFloat = diameter / 2.0

        let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)

        ringLayer = CAShapeLayer()
        newView.layer.addSublayer(ringLayer)

        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.CGColor

        let ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
        let ringRect: CGRect = CGRectInset(rect, ringLineWidthInset, ringLineWidthInset)
        let centrePoint: CGPoint = CGPointMake(ringRect.midX, ringRect.midY)
        let startAngle: CGFloat = CGFloat(-π/2.0)
        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        ringLayer.path = ringPath.CGPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }

    //Set dates for supplementary view
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        let daysofNoHeadache = [1,2,3,4,5, 20,21,23,17,30]
        guard let date = dayView.date else
        {
            return false
        }
        if daysofNoHeadache.contains((date.day)) {
             return true
        }
       return false
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TrackForTodaySegue"{
            let vc = segue.destinationViewController as! TrackerConfirmViewController
                vc.selectedDate =  calendarView.presentedDate.convertedDate()!
        }


    }

}


extension TrackerViewController :CVCalendarViewAppearanceDelegate
{
    func spaceBetweenWeekViews() -> CGFloat {
        return 0
    }

    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }

    func spaceBetweenDayViews() -> CGFloat {
        return 0
    }

    func dayLabelWeekdaySelectedBackgroundColor() -> UIColor {
        return UIColor(netHex:0x5DB8EB)
    }

    func dayLabelPresentWeekdayHighlightedBackgroundColor() -> UIColor {
        return UIColor(netHex:0xEE2546)
    }

//    func dotMarkerColor() -> UIColor {
//        return UIColor(netHex:0xB1E100)
//    }
}

