//
//  ViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-03-13.
//

import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

// will remove in the future and use swift object models
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

struct StuInput {
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

let studentInputData: [StuInput] = [
    StuInput(name: "Input 1", date: DateComponents(year: 2023, month: 4, day: 16), inputType: "Type 1"),
    StuInput(name: "Input 2", date: DateComponents(year: 2023, month: 4, day: 18), inputType: "Type 2"),
    StuInput(name: "Input 3", date: DateComponents(year: 2023, month: 4, day: 22), inputType: "Type 3"),
    StuInput(name: "Input 4", date: DateComponents(year: 2023, month: 5, day: 2), inputType: "Type 4")
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

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        
        do {
            let realm = try Realm()
            
            // for debugging
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            
            // test class
            createClass(realm: realm, name: "test class", color: "blue")
            
            // test posts
            let date = Date()
            let files = List<String>()
            createEvent(realm: realm, title: "testEvent", date: date, files: files)
            createAlert(realm: realm, title: "testAlert", date: date, files: files)
            createAssignment(realm: realm, title: "testAssignment", date: date, files: files)
            createStudentInput(realm: realm, title: "testStudentInput", date: date, inputType: "TEXT")
        } catch let error as NSError {
            print("Error initializing Realm: \(error.localizedDescription)")
        }
    }
        

    func createClass(realm: Realm, name: String, color: String) {
        let code = generateClassCode(realm: realm)
        let newClass = Class(name: name, color: color, code: code)
        try! realm.write {
             realm.add(newClass)
        }
    }
    
    // generate random 6-character code made up of 3 letters and 3 numbers
    func generateCode() -> String {
        var code = ""
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let nums = "1234567890"
        for _ in 0..<3 {
            let letterIndex = Int.random(in: 0..<letters.count)
            code.append(letters[letters.index(letters.startIndex, offsetBy: letterIndex)])
        }
        for _ in 0..<3 {
            let numIndex = Int.random(in: 0..<nums.count)
            code.append(nums[nums.index(nums.startIndex, offsetBy: numIndex)])
        }
        
        return code
    }
    
    // use generateCode() to create a random class code and ensure it is not already in use
    func generateClassCode(realm: Realm) -> String {
        var code = generateCode()
        while realm.objects(Class.self).filter("code == %@", code).count > 0 {
            code = generateCode()
        }
        return code
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
        ClassInfo(subject: "French", eventCount: "3", assignCount: "1", alertCount: "2", colour: UIColor.purple.withAlphaComponent(0.25)),
        ClassInfo(subject: "6A - Art", eventCount: "1", assignCount: "2", alertCount: "2", colour: UIColor.blue.withAlphaComponent(0.25)),
        ClassInfo(subject: "6B - Art", eventCount: "1", assignCount: "2", alertCount: "2", colour: UIColor.blue.withAlphaComponent(0.25)),
        ClassInfo(subject: "Social Studies", eventCount: "3", assignCount: "1", alertCount: "1", colour: UIColor.orange.withAlphaComponent(0.25)),
        ClassInfo(subject: "Gym", eventCount: "2", assignCount: "2", alertCount: "2", colour: UIColor.green.withAlphaComponent(0.25)),
        ClassInfo(subject: "Music", eventCount: "1", assignCount: "2", alertCount: "0", colour: UIColor.systemYellow.withAlphaComponent(0.25)),
        ClassInfo(subject: "Languages", eventCount: "0", assignCount: "2", alertCount: "2", colour: UIColor.systemPink.withAlphaComponent(0.25)),
        ClassInfo(subject: "Junior Girls Volleyball", eventCount: "2", assignCount: "0", alertCount: "2", colour: UIColor.systemMint.withAlphaComponent(0.25)),
        ClassInfo(subject: "Track and Field", eventCount: "1", assignCount: "0", alertCount: "1", colour: UIColor.systemGray.withAlphaComponent(0.25))
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
    
    func createAssignment(realm: Realm, title: String, date: Date, files: List<String>) {
        let newAssignment = Assignment(title: title, date: date, files: files)
        try! realm.write {
             realm.add(newAssignment)
        }
        createPost(realm: realm, title: title, date: date, postType: newAssignment.postType)
    }
    
    func createAlert(realm: Realm, title: String, date: Date, files: List<String>) {
        let newAlert = Alert(title: title, date: date, files: files)
        try! realm.write {
             realm.add(newAlert)
        }
        createPost(realm: realm, title: title, date: date, postType: newAlert.postType)
    }
    
    func createStudentInput(realm: Realm, title: String, date: Date, inputType: String) {
        let newStudentInput = StudentInput(title: title, date: date, inputType: inputType)
        try! realm.write {
             realm.add(newStudentInput)
        }
        createPost(realm: realm, title: title, date: date, postType: newStudentInput.postType)
    }
}

