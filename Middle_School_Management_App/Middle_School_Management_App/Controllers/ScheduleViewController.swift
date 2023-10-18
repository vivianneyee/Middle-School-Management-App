//
//  ScheduleViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

class ScheduleViewController: UIViewController, ECWeekViewDataSource, ECWeekViewDelegate, ECWeekViewStyler {
    
    @IBOutlet private var weekView: ECWeekView!
    
    func weekViewStylerHeaderView(_ weekView: ECWeekView, with date: DateInRegion, in cell: UICollectionViewCell) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 5, width: cell.bounds.width, height: 40))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: headerView.bounds.width, height: headerView.bounds.height))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        let dateString = date.toFormat(dateFormatter.dateFormat)
        label.text = dateString
        label.textAlignment = .center
        label.textColor = UIColor.black
        
        headerView.addSubview(label)
        return headerView
    }
    
    var font: UIFont = UIFont.systemFont(ofSize: 12)
    
    var showsDateHeader: Bool = true
    
    var dateHeaderHeight: CGFloat = 12
    var myStyler: ECWeekViewStyler = MyWeekViewStyler()
    
    
    
    //    let eventDetailLauncher = EventDetailLauncher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weekView.dataSource = self
        weekView.delegate = self
        weekView.styler = myStyler
        weekView.initDate = DateInRegion()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        weekView.dataSource = self
        weekView.delegate = self
    }
    
    func weekViewGenerateEvents(_ weekView: ECWeekView, date: DateInRegion, eventCompletion: @escaping ([ECWeekViewEvent]?) -> Void) -> [ECWeekViewEvent]? {
        let weekday = date.weekday
        if weekday == 7 || weekday == 1 {
            // No classes on Saturday and Sunday
            DispatchQueue.global(qos: .background).async {
                eventCompletion([])
            }
            return nil
        }
        
        // Create a dictionary of classes and their colors
        let classes = [
            "Math": UIColor.red,
            "6B - Art": UIColor.blue,
            "6A - Art": UIColor.blue,
            "Gym": UIColor.green,
            "Music": UIColor.yellow,
            "French": UIColor.purple,
            "Social Studies": UIColor.orange,
            "Planning Time": UIColor.cyan,
            "Languages": UIColor.systemPink
        ]
        
        // Create an array of schedules
        let schedules = [
            ["6B - Art", "6A - Art", "Gym", "Music", "French", "Social Studies", "Planning Time"],
            ["Gym", "6A - Art", "Music", "French", "Planning Time", "Languages", "Social Studies"],
            ["Music", "6A - Art", "6B - Art", "Gym", "Social Studies", "Languages", "French"],
            ["Social Studies", "Languages", "6B - Art", "6A - Art", "Planning Time", "Gym", "Music"],
            ["6A - Art", "Music", "Languages", "Social Studies", "6B - Art", "French", "Gym"],
            ["6B - Art", "Planning Time", "6A - Art", "Gym", "French", "Music", "Languages"],
            ["French", "Social Studies", "6A - Art", "Music", "Gym", "Languages", "Math"],
            ["Languages", "Social Studies", "6A - Art", "6B - Art", "Music", "Gym", "Planning Time"],
            ["Gym", "6A - Art", "Music", "French", "6B - Art", "Planning Time", "Languages"],
            ["Music", "6A - Art", "6B - Art", "Social Studies", "Languages", "Planning Time", "Gym"]
        ]
        
        // Get the schedule index for the current weekday
        let scheduleIndex = (weekday - 2) % 10
        
        // Get the schedule for the current weekday
        let schedule = schedules[scheduleIndex]
        
        var events = [ECWeekViewEvent]()
        for (index, className) in schedule.enumerated() {
            let startHour = 9 + index
            let startDate = date.dateBySet(hour: startHour, min: 0, secs: 0)!
            let endDate = date.dateBySet(hour: startHour + 1, min: 0, secs: 0)!
            
            // Create a new event for the class
            let event = ECWeekViewEvent(title: className, subtitle: "Period " + String(index+1), start: startDate, end: endDate)
            
            // Set the event color based on the class
            //            if let color = classes[className] {
            //                event.color = color
            //            }
            
            events.append(event)
        }
        
        DispatchQueue.global(qos: .background).async {
            eventCompletion(events)
        }
        
        return nil
    }
    
    func weekViewDidClickOnEvent(_ weekView: ECWeekView, event: ECWeekViewEvent, view: UIView) {
        //        eventDetailLauncher.event = event
        //        eventDetailLauncher.present()
    }
    
    func weekViewDidClickOnFreeTime(_ weekView: ECWeekView, date: DateInRegion) {
        print(#function, "date:", date.toString())
    }
    
    // Creates the view for an event
    func weekViewStylerECEventView(_ weekView: ECWeekView, eventContainer: CGRect, event: ECWeekViewEvent) -> UIView {
        let eventView = UIView(frame: eventContainer)
        eventView.layer.cornerRadius = 10
        eventView.layer.masksToBounds = true
        
        // Create a dictionary of classes and their colors
        let classes = [
            "Math": UIColor.red,
            "6B - Art": UIColor.blue,
            "6A - Art": UIColor.blue,
            "Gym": UIColor.green,
            "Music": UIColor.yellow,
            "French": UIColor.purple,
            "Social Studies": UIColor.orange,
            "Planning Time": UIColor.cyan,
            "Languages": UIColor.systemPink
        ]
        
        
        if let classColor = classes[event.title] {
            print(classes)
            eventView.backgroundColor = UIColor.clear
            eventView.layer.borderColor = classColor.cgColor // Set border color to match background color
            eventView.layer.borderWidth = 1.0 // Set border width to 1.0 point
        } else {
            eventView.backgroundColor = UIColor.gray
        }
        
        
        return eventView
    }
}

class MyWeekViewStyler: ECWeekViewStyler {
    func weekViewStylerHeaderView(_ weekView: ECWeekView, with date: DateInRegion, in cell: UICollectionViewCell) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: cell.bounds.width, height: 12))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: headerView.bounds.width, height: headerView.bounds.height))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE d"
        let dateString = date.toFormat(dateFormatter.dateFormat)
        label.text = dateString
        label.textAlignment = .center
        label.textColor = UIColor.black
        
        headerView.addSubview(label)
        return headerView
    }
    
    var font: UIFont = UIFont.systemFont(ofSize: 10)
    
    var showsDateHeader: Bool = true
    
    var dateHeaderHeight: CGFloat = 12
    
    
    
    // Creates the view for an event
    func weekViewStylerECEventView(_ weekView: ECWeekView, eventContainer: CGRect, event: ECWeekViewEvent) -> UIView {
        let eventView = UIView(frame: eventContainer)
        eventView.layer.cornerRadius = 0
        eventView.layer.masksToBounds = true
        
        // Create a dictionary of classes and their colors
        let classes = [
            "Math": UIColor.red,
            "6B - Art": UIColor.blue,
            "6A - Art": UIColor.blue,
            "Gym": UIColor.green,
            "Music": UIColor.yellow,
            "French": UIColor.purple,
            "Social Studies": UIColor.orange,
            "Planning Time": UIColor.cyan,
            "Languages": UIColor.systemPink
        ]
        
        
        if let classColor = classes[event.title] {
            print(classes)
            eventView.backgroundColor = classColor.withAlphaComponent(0.25)
            eventView.layer.borderColor = classColor.withAlphaComponent(0.25).cgColor // Set border color to match background color
            eventView.layer.borderWidth = 1.0 // Set border width to 1.0 point
            
            if eventView.backgroundColor == UIColor.blue || eventView.backgroundColor == UIColor.purple {
                let labelTitle = UILabel(frame: CGRect(x: 5, y: 2, width: eventView.bounds.width - 5, height: eventView.bounds.height / 2))
                let labelSub = UILabel(frame: CGRect(x: 5, y: eventView.bounds.height / 2, width: eventView.bounds.width - 5, height: eventView.bounds.height / 2))
                labelTitle.text = event.title
                labelTitle.font = font
                labelTitle.textColor = UIColor.white // Change text color as desired
                labelTitle.textAlignment = .left
                labelTitle.numberOfLines = 0
                labelTitle.sizeToFit()
                
                labelSub.text = event.subtitle
                labelSub.font = font
                labelSub.textColor = UIColor.white // Change text color as desired
                labelSub.textAlignment = .left
                labelSub.numberOfLines = 0
                labelSub.sizeToFit()
                
                eventView.addSubview(labelTitle)
                eventView.addSubview(labelSub)
            } else {
                let labelTitle = UILabel(frame: CGRect(x: 5, y: 2, width: eventView.bounds.width - 5, height: eventView.bounds.height / 2))
                let labelSub = UILabel(frame: CGRect(x: 5, y: eventView.bounds.height / 2, width: eventView.bounds.width - 5, height: eventView.bounds.height / 2))
                labelTitle.text = event.title
                labelTitle.font = font
                labelTitle.textColor = UIColor.black // Change text color as desired
                labelTitle.textAlignment = .left
                labelTitle.numberOfLines = 0
                labelTitle.sizeToFit()
                
                labelSub.text = event.subtitle
                labelSub.font = font
                labelSub.textColor = UIColor.black // Change text color as desired
                labelSub.textAlignment = .left
                labelSub.numberOfLines = 0
                labelSub.sizeToFit()
                
                eventView.addSubview(labelTitle)
                eventView.addSubview(labelSub)
            }
        } else {
            eventView.backgroundColor = UIColor.gray
        }
        
        return eventView
    }
}
