//
//  ViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-03-13.
//

import UIKit
import ECWeekView
import SwiftDate

struct PostInfo {
    let name: String
    let date: DateComponents
    // let file:
}

struct NotifInfo {
    let name: String
    let notif: String
    let date: DateComponents
    // let file:
}

struct StudentInput {
    let name: String
    let date: DateComponents
    let inputType: String
}

struct DailySche {
    let period1: String
    let period2: String
    let period3: String
    let period4: String
    let period5: String
    let period6: String
    let period7: String
}

// hardcoded data for testing, actual object will have a file field
let eventData: [PostInfo] = [
    PostInfo(name: "Unit 2 Test", date: DateComponents(year: 2023, month: 4, day: 18)),
    PostInfo(name: "Unit 3 Quiz", date: DateComponents(year: 2023, month: 4, day: 22)),
    PostInfo(name: "Guest Speaker", date: DateComponents(year: 2023, month: 5, day: 12)),
    PostInfo(name: "Unit 3 Test", date: DateComponents(year: 2023, month: 5, day: 16))
]

let assignData: [PostInfo] = [
    PostInfo(name: "Assignment 2", date: DateComponents(year: 2023, month: 4, day: 18)),
    PostInfo(name: "Assignment 3", date: DateComponents(year: 2023, month: 4, day: 24)),
    PostInfo(name: "Assignment 4", date: DateComponents(year: 2023, month: 5, day: 8))
]

let alertData: [PostInfo] = [
    PostInfo(name: "Alert 1", date: DateComponents(year: 2023, month: 4, day: 18)),
    PostInfo(name: "Alert 2", date: DateComponents(year: 2023, month: 4, day: 21)),
    PostInfo(name: "Alert 3", date: DateComponents(year: 2023, month: 4, day: 26)),
    PostInfo(name: "Alert 4", date: DateComponents(year: 2023, month: 5, day: 5))
]

var allNotifs: [NotifInfo] = [
    NotifInfo(name: "6A - Art", notif: "Unit 2 Test", date: DateComponents(year: 2023, month: 4, day: 18)),
    NotifInfo(name: "6B - Art", notif: "Unit 2 Test", date: DateComponents(year: 2023, month: 4, day: 18)),
    NotifInfo(name: "French", notif: "Assignment 2 Due", date: DateComponents(year: 2023, month: 4, day: 19)),
    NotifInfo(name: "Junior Girls Volleyball", notif: "Volleyball game", date: DateComponents(year: 2023, month: 4, day: 19)),
    NotifInfo(name: "Social Studies", notif: "Unit 3 Quiz", date: DateComponents(year: 2023, month: 4, day: 21)),
    NotifInfo(name:"Music", notif: "Guest Speaker", date: DateComponents(year: 2023, month: 4, day: 22)),
    NotifInfo(name: "Junior Girls Volleyball", notif: "Volleyball game", date: DateComponents(year: 2023, month: 4, day: 25)),
    NotifInfo(name:"French", notif: "Assignment 3 Due", date: DateComponents(year: 2023, month: 4, day: 27)),
    NotifInfo(name: "Track and Field", notif: "Track meet", date: DateComponents(year: 2023, month: 5, day: 1))
]

let studentInputData: [StudentInput] = [
    StudentInput(name: "Input 1", date: DateComponents(year: 2023, month: 4, day: 16), inputType: "Type 1"),
    StudentInput(name: "Input 2", date: DateComponents(year: 2023, month: 4, day: 18), inputType: "Type 2"),
    StudentInput(name: "Input 3", date: DateComponents(year: 2023, month: 4, day: 22), inputType: "Type 3"),
    StudentInput(name: "Input 4", date: DateComponents(year: 2023, month: 5, day: 2), inputType: "Type 4")
]

// using this for capstone demo
let weeklySche: [DailySche] = [
    DailySche(period1: "Math", period2: "Art", period3: "Gym", period4: "Music", period5: "French", period6: "Social Studies", period7: "Science"),
    DailySche(period1: "Languages", period2: "Math", period3: "Science", period4: "Art", period5: "Gym", period6: "Music", period7: "French"),
    DailySche(period1: "Social Studies", period2: "Science", period3: "Gym", period4: "French", period5: "Music", period6: "Languages", period7: "Math"),
    DailySche(period1: "Music", period2: "French", period3: "Art", period4: "Languages", period5: "Science", period6: "Math", period7: "Gym"),
    DailySche(period1: "Science", period2: "Gym", period3: "Music", period4: "Math", period5: "Art", period6: "French", period7: "Languages")
]

let classColours = [
    "Math": UIColor.red,
    "Art": UIColor.blue,
    "Gym": UIColor.green,
    "Music": UIColor.yellow,
    "French": UIColor.purple,
    "Social Studies": UIColor.orange,
    "Science": UIColor.cyan,
    "Languages": UIColor.systemPink
]

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

class ProfileViewController: UIViewController {
    
    @IBAction func tapToSettings(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "settings") as! SettingsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapToNotifPref(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "notifpref") as! NotificationPrefViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }
    
}

class NotificationPrefViewController: UITableViewController {
    
    @IBOutlet var switchNotif: UISwitch!
    @IBOutlet var switchEvents: UISwitch!
    @IBOutlet var switchAssignments: UISwitch!
    @IBOutlet var switchAlerts: UISwitch!
    @IBOutlet var switchContent: UISwitch!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notification Preferences"
    }
    
    @IBAction func switchNotifChanged (_ sender: UISwitch) {
        if sender.isOn {
            // CHANGE LATER TO TURN ON NOTIF this is just for testing ....
            view.backgroundColor = .systemPink
        } else {
            view.backgroundColor = .white
        }
    }
    
    @IBAction func switchEventsChanged (_ sender: UISwitch) {
        if sender.isOn {
            // CHANGE LATER TO TURN ON NOTIF this is just for testing ....
            view.backgroundColor = .systemBlue
        } else {
            view.backgroundColor = .white
        }
    }
    
    @IBAction func switchAssignmentsChanged (_ sender: UISwitch) {
        if sender.isOn {
            // CHANGE LATER TO TURN ON NOTIF this is just for testing ....
            view.backgroundColor = .systemRed
        } else {
            view.backgroundColor = .white
        }
    }
    
    @IBAction func switchAlertsChanged (_ sender: UISwitch) {
        if sender.isOn {
            // CHANGE LATER TO TURN ON NOTIF this is just for testing ....
            view.backgroundColor = .systemMint
        } else {
            view.backgroundColor = .white
        }
    }
    
    @IBAction func switchContentChanged (_ sender: UISwitch) {
        if sender.isOn {
            // CHANGE LATER TO TURN ON NOTIF this is just for testing ....
            view.backgroundColor = .systemPurple
        } else {
            view.backgroundColor = .white
        }
    }
}

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
            eventView.backgroundColor = classColor
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
            eventView.backgroundColor = classColor
            eventView.layer.borderColor = classColor.cgColor // Set border color to match background color
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



class NotificationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.dataSource = self
        table.delegate = self
        
    }
    
    //    @objc func didTapAdd() {
    //        let vc = storyboard?.instantiateViewController(identifier: "createPost") as! CreatePostViewController
    //        navigationController?.pushViewController(vc, animated: true)
    //
    //        vc.title = "Create New Event"
    //    }
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNotifs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dcFormatter = DateComponentsFormatter()
        dcFormatter.includesApproximationPhrase = false
        dcFormatter.allowedUnits = [.month, .day, .year]
        
        let eventCell = allNotifs[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotifTableViewCell
        
        let date = Calendar.current.date(from: eventCell.date)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        
        
        cell.date.text = formatter.string(from : date!)
        
        cell.className.text = eventCell.name
        
        cell.notif.text = eventCell.notif
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

class ClassesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    struct ClassInfo {
        let subject: String
        let eventCount: String
        let assignCount: String
        let alertCount: String
        let colour: UIColor
    }
    
    // hardcoded data for testing
    let data: [ClassInfo] = [
        ClassInfo(subject: "French", eventCount: "3", assignCount: "1", alertCount: "2", colour: UIColor.purple),
        ClassInfo(subject: "6A - Art", eventCount: "1", assignCount: "2", alertCount: "2", colour: UIColor.blue),
        ClassInfo(subject: "6B - Art", eventCount: "1", assignCount: "2", alertCount: "2", colour: UIColor.blue),
        ClassInfo(subject: "Social Studies", eventCount: "3", assignCount: "1", alertCount: "1", colour: UIColor.orange),
        ClassInfo(subject: "Gym", eventCount: "2", assignCount: "2", alertCount: "2", colour: UIColor.green),
        ClassInfo(subject: "Music", eventCount: "1", assignCount: "2", alertCount: "0", colour: UIColor.yellow),
        ClassInfo(subject: "Languages", eventCount: "0", assignCount: "2", alertCount: "2", colour: UIColor.systemPink),
        ClassInfo(subject: "Junior Girls Volleyball", eventCount: "2", assignCount: "0", alertCount: "2", colour: UIColor.systemMint),
        ClassInfo(subject: "Track and Field", eventCount: "1", assignCount: "0", alertCount: "1", colour: UIColor.systemGray)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.dataSource = self
        table.delegate = self
    }
    
    @objc func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "createClass") as! CreateClassViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let classCell = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClassTableViewCell
        cell.className.text = classCell.subject
        cell.events.text = "Events - " + classCell.eventCount
        cell.assignments.text = "Assignments - " + classCell.assignCount
        cell.alerts.text = "Alerts - " + classCell.alertCount
        let font = UIFont.systemFont(ofSize: 25)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let im = UIImage(systemName: "circle.fill", withConfiguration: configuration)?.withRenderingMode(.alwaysOriginal).withTintColor(classCell.colour)
        cell.colour.image = im
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let classCell = data[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "classInfo") as! ClassInfoViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = classCell.subject
    }
}

class CreateClassViewController: UIViewController {
    
    @IBOutlet var field: UITextField!
    @IBOutlet var colour: UIColorWell!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create New Class"
    }
    
    @IBAction func tappedSubmit() {
        // add submit stuff
    }
}

class ClassInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    let labels: [String] = [
        "Events",
        "Assignments",
        "Alerts",
        "Student Input"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let labelCell = labels[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LinkTableViewCell
        cell.labelName.text = labelCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let labelCell = labels[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(identifier: "event") as! EventViewController
        
        if (labelCell == "Events") {
            let vc = storyboard?.instantiateViewController(identifier: "event") as! EventViewController
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Events"
        } else if (labelCell == "Assignments") {
            let vc = storyboard?.instantiateViewController(identifier: "assign") as! AssignmentViewController
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Assignments"
        } else if (labelCell == "Alerts") {
            let vc = storyboard?.instantiateViewController(identifier: "alert") as! AlertViewController
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Alerts"
        } else if (labelCell == "Student Input") {
            let vc = storyboard?.instantiateViewController(identifier: "sInput") as! StudentInputViewController
            navigationController?.pushViewController(vc, animated: true)
            vc.title = "Student Input"
        }
        
        vc.title = labelCell
    }
    
}

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.dataSource = self
        table.delegate = self
    }
    
    @objc func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "createPost") as! CreatePostViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = "Create New Event"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dcFormatter = DateComponentsFormatter()
        dcFormatter.includesApproximationPhrase = false
        dcFormatter.allowedUnits = [.month, .day, .year]
        
        let eventCell = eventData[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        
        let date = Calendar.current.date(from: eventCell.date)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        cell.date.text = formatter.string(from : date!)
        
        cell.name.text = eventCell.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventCell = eventData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "edit") as! EditViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = "Edit " + eventCell.name
        
    }
}

class AssignmentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.dataSource = self
        table.delegate = self
    }
    
    @objc func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "createPost") as! CreatePostViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = "Create New Assignment"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dcFormatter = DateComponentsFormatter()
        dcFormatter.includesApproximationPhrase = false
        dcFormatter.allowedUnits = [.month, .day, .year]
        
        let eventCell = assignData[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        
        let date = Calendar.current.date(from: eventCell.date)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        cell.date.text = formatter.string(from : date!)
        
        cell.name.text = eventCell.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventCell = assignData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "edit") as! EditViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = "Edit " + eventCell.name
        
    }
}

class AlertViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.dataSource = self
        table.delegate = self
    }
    
    @objc func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "createPost") as! CreatePostViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = "Create New Alert"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dcFormatter = DateComponentsFormatter()
        dcFormatter.includesApproximationPhrase = false
        dcFormatter.allowedUnits = [.month, .day, .year]
        
        let eventCell = alertData[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        
        let date = Calendar.current.date(from: eventCell.date)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        cell.date.text = formatter.string(from : date!)
        
        cell.name.text = eventCell.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventCell = alertData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "edit") as! EditViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = "Edit " + eventCell.name
        
    }
}

// EVENT, ASSIGNMENT, ALERT
class CreatePostViewController: UIViewController {
    @IBOutlet weak var dateTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTF.inputView = datePicker
        
        dateTF.text = formatDate(date: Date())
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        dateTF.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
    }
    
    @IBAction func tappedCreate() {
        // add create stuff
    }
    
}

// EVENT, ASSIGNMENT, ALERT
// code functionality later...
class EditViewController: UIViewController {
    
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    var postTitle: String?
    var postDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTF.inputView = datePicker
        
        for (index, event) in eventData.enumerated() {
            if "Edit " + event.name == title {
                let date = Calendar.current.date(from: eventData[index].date)
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM dd yyyy"
                dateTF.text = formatter.string(from : date!)
                
                titleTF.text = event.name
            }
        }
        
        for (index, assign) in assignData.enumerated() {
            if "Edit " + assign.name == title {
                let date = Calendar.current.date(from: assignData[index].date)
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM dd yyyy"
                dateTF.text = formatter.string(from : date!)
                
                titleTF.text = assign.name
            }
        }
        
        for (index, alert) in alertData.enumerated() {
            if "Edit " + alert.name == title {
                print(true)
                let date = Calendar.current.date(from: alertData[index].date)
                let formatter = DateFormatter()
                formatter.dateFormat = "MMMM dd yyyy"
                dateTF.text = formatter.string(from : date!)
                
                titleTF.text = alertData[index].name
                
            }
        }
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        dateTF.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
    }
    
    @IBAction func tappedSave() {
        // add save stuff
    }
}

class StudentInputViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.dataSource = self
        table.delegate = self
    }
    
    @objc func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "createSI") as! CreateStudentInputViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = "Create New Student Input"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentInputData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dcFormatter = DateComponentsFormatter()
        dcFormatter.includesApproximationPhrase = false
        dcFormatter.allowedUnits = [.month, .day, .year]
        
        let eventCell = studentInputData[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        
        let date = Calendar.current.date(from: eventCell.date)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        cell.date.text = formatter.string(from : date!)
        
        cell.name.text = eventCell.name
        
        cell.inputType.text = eventCell.inputType
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventCell = studentInputData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "editSI") as! EditStudentInputViewController
        navigationController?.pushViewController(vc, animated: true)
        
        vc.title = "Edit " + eventCell.name
    }
}

class CreateStudentInputViewController: UIViewController {
    @IBOutlet weak var dateTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTF.inputView = datePicker
        
        dateTF.text = formatDate(date: Date())
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        dateTF.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
    }
    
    @IBAction func tappedCreate() {
        // add create stuff
    }
}

class EditStudentInputViewController: UIViewController {
    @IBOutlet weak var dateTF: UITextField!
    var postTitle: String?
    var postDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTF.inputView = datePicker
        
        dateTF.text = formatDate(date: Date())
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        dateTF.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
    }
    
    @IBAction func tappedSave() {
        // add save stuff
    }
}

class JoinClassViewController: UIViewController {
    
    @IBOutlet var field: UITextField!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedSubmit() {
        // add submit stuff
    }
}
