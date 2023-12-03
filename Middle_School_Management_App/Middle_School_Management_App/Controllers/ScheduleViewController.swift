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
    var userID: String = ""
    let userController = UserController()
    let scheduleController = ScheduleController()
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
    var myStyler: MyWeekViewStyler = MyWeekViewStyler()
    var scheduleID: String = ""
    // Get the schedule for the current weekday
    var day1Sche: [String] = []
    var day2Sche: [String] = []
    var day3Sche: [String] = []
    var day4Sche: [String] = []
    var day5Sche: [String] = []
    var day6Sche: [String] = []
    var day7Sche: [String] = []
    var day8Sche: [String] = []
    var day9Sche: [String] = []
    var day10Sche: [String] = []
    var scheduleArray: [[String]] = [[]]
    var classToColour: [String:String] = ["":""]
    let classController = ClassController()
    //    let eventDetailLauncher = EventDetailLauncher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weekView.dataSource = self
        weekView.delegate = self
        weekView.styler = myStyler
        weekView.initDate = DateInRegion()
        print("schedule page userID: ", self.userID)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEdit))
        userController.getUserById(id: self.userID) { [self] result in
            switch result {
            case .success(let user):
                print("able to get user on schedule page", user)
//                if let scheduleID = user.schedule?._id {
                scheduleController.getScheduleById(id: user.schedule) { [self] result in
                        switch result {
                        case .success(let schedule):
                            print("schedule exists", schedule)
                            DispatchQueue.main.async {
                                self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.didTapEdit))
                            }
                            print("testing")
                            self.day1Sche = schedule.day1
                            self.day2Sche = schedule.day2
                            self.day3Sche = schedule.day3
                            self.day4Sche = schedule.day4
                            self.day5Sche = schedule.day5
                            self.day6Sche = schedule.day6
                            self.day7Sche = schedule.day7
                            self.day8Sche = schedule.day8
                            self.day9Sche = schedule.day9
                            self.day10Sche = schedule.day10
                                
                            self.scheduleArray = [day1Sche, day2Sche, day3Sche, day4Sche, day5Sche, day6Sche, day7Sche, day8Sche, day9Sche, day10Sche]
                            for d in scheduleArray {
                                print("for d in scheduleArray {")
                                for c in d {
                                    print("Current class name", c)
                                    if !(c.isEmpty) {
                                        classController.getClassByName(className: c) { [self] result in
                                            switch result {
                                            case .success(let cl):
                                                print("get class by name successs", cl)
                                                self.classToColour.updateValue(cl.class.color, forKey: cl.class.className)
                                            case .failure(let error):
                                                print("get class by name failed", error)
                                            }
                                            
                                        }
                                    } else {
                                        print("no class for that period, c:", c)
                                    }
                                }
                            }
                            myStyler.classToColour = self.classToColour
                        case .failure (let error):
                            print("failed to get schedule", error)
                        }
                    }
//                } else {
//                    print("user has no schedule?")
//                }
            case .failure(let error):
                print("failed to get user on schedule page", error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        weekView.dataSource = self
        weekView.delegate = self
//        DispatchQueue.main.async {
//            weekView.reloadData()
//        }
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
//        let classes = [
//            "Math": UIColor.red,
//            "6B - Art": UIColor.blue,
//            "6A - Art": UIColor.blue,
//            "Gym": UIColor.green,
//            "Music": UIColor.yellow,
//            "French": UIColor.purple,
//            "Social Studies": UIColor.orange,
//            "Planning Time": UIColor.cyan,
//            "Languages": UIColor.systemPink
//        ]
//
        // Create an array of schedules
//        let schedules = [
//            ["6B - Art", "6A - Art", "Gym", "Music", "French", "Social Studies", "Planning Time"],
//            ["Gym", "6A - Art", "Music", "French", "Planning Time", "Languages", "Social Studies"],
//            ["Music", "6A - Art", "6B - Art", "Gym", "Social Studies", "Languages", "French"],
//            ["Social Studies", "Languages", "6B - Art", "6A - Art", "Planning Time", "Gym", "Music"],
//            ["6A - Art", "Music", "Languages", "Social Studies", "6B - Art", "French", "Gym"],
//            ["6B - Art", "Planning Time", "6A - Art", "Gym", "French", "Music", "Languages"],
//            ["French", "Social Studies", "6A - Art", "Music", "Gym", "Languages", "Math"],
//            ["Languages", "Social Studies", "6A - Art", "6B - Art", "Music", "Gym", "Planning Time"],
//            ["Gym", "6A - Art", "Music", "French", "6B - Art", "Planning Time", "Languages"],
//            ["Music", "6A - Art", "6B - Art", "Social Studies", "Languages", "Planning Time", "Gym"]
//        ]
//        let schedules = userController.getUserById(id: userID) { Result<User, Error> in
//
//        }
//        var schedules = Schedule()
        userController.getUserById(id: self.userID) { [self] result in
            switch result {
            case .success(let user):
//                if let scheduleID = user.schedule?._id {
                    self.scheduleID = scheduleID
                    // Access the schedule property of the user
                    let schedules = user.schedule
                        // Get the schedule index for the current weekday
                    let scheduleIndex = (weekday - 2) % 10
                scheduleController.getScheduleById(id: schedules) { [self] result in
                        switch result {
                        case .success(let schedule):
                            print("schedule exists")
                            DispatchQueue.main.async {
                                self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.didTapEdit))
                            }
                            self.day1Sche = schedule.day1
                            self.day2Sche = schedule.day2
                            self.day3Sche = schedule.day3
                            self.day4Sche = schedule.day4
                            self.day5Sche = schedule.day5
                            self.day6Sche = schedule.day6
                            self.day7Sche = schedule.day7
                            self.day8Sche = schedule.day8
                            self.day9Sche = schedule.day9
                            self.day10Sche = schedule.day10
                                
                            self.scheduleArray = [day1Sche, day2Sche, day3Sche, day4Sche, day5Sche, day6Sche, day7Sche, day8Sche, day9Sche, day10Sche]
                            for d in scheduleArray {
                                for c in d {
                                    print("Current class name", c)
                                    if !(c.isEmpty) {
                                        classController.getClassByName(className: c) { [self] result in
                                            switch result {
                                            case .success(let cl):
                                                print("get class by name successs", cl)
                                                self.classToColour.updateValue(cl.class.color, forKey: cl.class.className)
                                            case .failure(let error):
                                                print("get class by name failed", error)
                                            }
                                            
                                        }
                                    } else {
                                        print("no class for that period, c:", c)
                                    }
                                }
                            }
                            myStyler.classToColour = self.classToColour
                            print("self.classToColour", self.classToColour)
                        case .failure (let error):
                            print("failed to get schedule", error)
                        }
                    }
                        
//                        // Get the schedule for the current weekday
//                    self.day1Sche = schedules.day1
//                    self.day2Sche = schedules.day2
//                    self.day3Sche = schedules.day3
//                    self.day4Sche = schedules.day4
//                    self.day5Sche = schedules.day5
//                    self.day6Sche = schedules.day6
//                    self.day7Sche = schedules.day7
//                    self.day8Sche = schedules.day8
//                    self.day9Sche = schedules.day9
//                    self.day10Sche = schedules.day10
                        
                    self.scheduleArray = [day1Sche, day2Sche, day3Sche, day4Sche, day5Sche, day6Sche, day7Sche, day8Sche, day9Sche, day10Sche]
                    
                    let schedule = self.scheduleArray[scheduleIndex]
                    
                    var events = [ECWeekViewEvent]()
                    
                    for (index, className) in schedule.enumerated() {
                        let startHour = 9 + index
                        let startDate = date.dateBySet(hour: startHour, min: 0, secs: 0)!
                        let endDate = date.dateBySet(hour: startHour + 1, min: 0, secs: 0)!
                        
                        // Create a new event for the class
                        let event = ECWeekViewEvent(title: className, subtitle: "Period " + String(index+1), start: startDate, end: endDate)

                        
                        events.append(event)
                    }
                    DispatchQueue.global(qos: .background).async {
                        eventCompletion(events)
                    }
//                } else {
//                    // Handle the case where scheduleID is nil
//                    // Perhaps set a default value or show an error message
//                }
//                self.scheduleID = user.schedule!._id
               
//                } else {
//                    // Handle nil schedule here
//                    DispatchQueue.global(qos: .background).async {
//                        eventCompletion([])
//                    }
//                }
            case .failure(let error):

                print("Error: \(error)")
            }
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
        
        // go through schedule array
        // get each class id
        // get class by id and get the corresponding color and then set the color for each class
        // Create a dictionary of classes and their colors
//        let classes = [
//            "Math": UIColor.red,
//            "6B - Art": UIColor.blue,
//            "6A - Art": UIColor.blue,
//            "Gym": UIColor.green,
//            "Music": UIColor.yellow,
//            "French": UIColor.purple,
//            "Social Studies": UIColor.orange,
//            "Planning Time": UIColor.cyan,
//            "Languages": UIColor.systemPink
//        ]
//
        
        if let classColor = classToColour[event.title] {
            if let color = UIColor(hex: classColor) {
                eventView.backgroundColor = color.withAlphaComponent(0.25)
                eventView.layer.borderColor = color.withAlphaComponent(0.25).cgColor // Set border color to match background color
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
                eventView.backgroundColor = UIColor.clear
            }
        }
        
        
        
        return eventView
    }
    
        @objc func didTapAdd() {
            let vc = storyboard?.instantiateViewController(identifier: "scheInfo") as! ScheduleInfoViewController
            navigationController?.pushViewController(vc, animated: true)
    
            vc.title = "Create New Schedule"
            vc.scheduleID = self.scheduleID
            vc.userID = self.userID
        }
    
    @objc func didTapEdit() {
        let vc = storyboard?.instantiateViewController(identifier: "scheInfo") as! ScheduleInfoViewController
        navigationController?.pushViewController(vc, animated: true)

        vc.title = "Edit Schedule"
        vc.scheduleID = self.scheduleID
        vc.userID = self.userID
    }
    
}

class MyWeekViewStyler: ECWeekViewStyler {
    var classToColour: [String:String] = ["":""]
    func updateClassColors(_ colors: [String: String]) {
            classToColour = colors
        }
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
//        let classes = [
//            "Math": UIColor.red,
//            "6B - Art": UIColor.blue,
//            "6A - Art": UIColor.blue,
//            "Gym": UIColor.green,
//            "Music": UIColor.yellow,
//            "French": UIColor.purple,
//            "Social Studies": UIColor.orange,
//            "Planning Time": UIColor.cyan,
//            "Languages": UIColor.systemPink
//        ]
//
        if let classColor = classToColour[event.title] {
            if let color = UIColor(hex: classColor) {
                eventView.backgroundColor = color.withAlphaComponent(0.25)
                eventView.layer.borderColor = color.withAlphaComponent(0.25).cgColor // Set border color to match background color
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
                eventView.backgroundColor = UIColor.clear
            }
        }
        
        
//        if let classColor = classes[event.title] {
//            print(classes)
//            eventView.backgroundColor = classColor.withAlphaComponent(0.25)
//            eventView.layer.borderColor = classColor.withAlphaComponent(0.25).cgColor // Set border color to match background color
//            eventView.layer.borderWidth = 1.0 // Set border width to 1.0 point
//
//            if eventView.backgroundColor == UIColor.blue || eventView.backgroundColor == UIColor.purple {
//                let labelTitle = UILabel(frame: CGRect(x: 5, y: 2, width: eventView.bounds.width - 5, height: eventView.bounds.height / 2))
//                let labelSub = UILabel(frame: CGRect(x: 5, y: eventView.bounds.height / 2, width: eventView.bounds.width - 5, height: eventView.bounds.height / 2))
//                labelTitle.text = event.title
//                labelTitle.font = font
//                labelTitle.textColor = UIColor.white // Change text color as desired
//                labelTitle.textAlignment = .left
//                labelTitle.numberOfLines = 0
//                labelTitle.sizeToFit()
//
//                labelSub.text = event.subtitle
//                labelSub.font = font
//                labelSub.textColor = UIColor.white // Change text color as desired
//                labelSub.textAlignment = .left
//                labelSub.numberOfLines = 0
//                labelSub.sizeToFit()
//
//                eventView.addSubview(labelTitle)
//                eventView.addSubview(labelSub)
//            } else {
//                let labelTitle = UILabel(frame: CGRect(x: 5, y: 2, width: eventView.bounds.width - 5, height: eventView.bounds.height / 2))
//                let labelSub = UILabel(frame: CGRect(x: 5, y: eventView.bounds.height / 2, width: eventView.bounds.width - 5, height: eventView.bounds.height / 2))
//                labelTitle.text = event.title
//                labelTitle.font = font
//                labelTitle.textColor = UIColor.black // Change text color as desired
//                labelTitle.textAlignment = .left
//                labelTitle.numberOfLines = 0
//                labelTitle.sizeToFit()
//
//                labelSub.text = event.subtitle
//                labelSub.font = font
//                labelSub.textColor = UIColor.black // Change text color as desired
//                labelSub.textAlignment = .left
//                labelSub.numberOfLines = 0
//                labelSub.sizeToFit()
//
//                eventView.addSubview(labelTitle)
//                eventView.addSubview(labelSub)
//            }
//        } else {
//            eventView.backgroundColor = UIColor.gray
//        }
//
        return eventView
    }
}
//extension UIColor {
//    convenience init?(hex: String) {
//        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
//        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
//
//        var rgb: UInt64 = 0
//
//        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
//            return nil
//        }
//
//        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
//        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
//        let blue = CGFloat(rgb & 0x0000FF) / 255.0
//
//        self.init(red: red, green: green, blue: blue, alpha: 1.0)
//    }
//}
