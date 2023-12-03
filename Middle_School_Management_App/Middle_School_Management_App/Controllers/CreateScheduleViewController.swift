//
//  CreateScheduleViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-11-30.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

// EVENT, ASSIGNMENT, ALERT
class CreateScheduleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
//    @IBOutlet weak var dayTF: UITextField!
    @IBOutlet weak var period1TF: UITextField!
    @IBOutlet weak var period2TF: UITextField!
    @IBOutlet weak var period3TF: UITextField!
    @IBOutlet weak var period4TF: UITextField!
    @IBOutlet weak var period5TF: UITextField!
    @IBOutlet weak var period6TF: UITextField!
    @IBOutlet weak var period7TF: UITextField!
    @IBOutlet weak var button: UIButton!
//    @IBOutlet weak var classTF: UITextField!
    
    var className: String = ""
    var userID: String = ""
    var classID: String = ""
    var scheduleID: String = ""
    var changedDays: [Int] = [-1]
    var scheduleData: [[String]] = [["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""]]
    var scheduleDataID: [[String]] = [["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""], ["","","","","","",""]]
    // Array of options for the priority dropdown
    let dayOptions = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5", "Day 6", "Day 7", "Day 8", "Day 9", "Day 10",]
    let periodOptions = ["Period 1", "Period 2", "Period 3", "Period 4", "Period 5", "Period 6", "Period 7"]
    var classOptions: [Class] = []
    var currentDay: Int = 0
    
    // Picker view for the dropdown options
    let periodPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

    // Picker view for the dropdown options
    let dayPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    // Picker view for the dropdown options
    let p1PickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    // Picker view for the dropdown options
    let p2PickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    // Picker view for the dropdown options
    let p3PickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    // Picker view for the dropdown options
    let p4PickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    // Picker view for the dropdown options
    let p5PickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    // Picker view for the dropdown options
    let p6PickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    // Picker view for the dropdown options
    let p7PickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("curent day", self.currentDay)
        self.changedDays.append(self.currentDay)
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(scrollView)
//
//        let contentView = UIView()
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(contentView)
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
//        ])

//        periodPickerView.delegate = self
//        dayPickerView.delegate = self
//        classPickerView.delegate = self
//
//        periodPickerView.dataSource = self
//        dayPickerView.dataSource = self
//        classPickerView.dataSource = self
        p1PickerView.delegate = self
        p1PickerView.dataSource = self

        p2PickerView.delegate = self
        p2PickerView.dataSource = self

        p3PickerView.delegate = self
        p3PickerView.dataSource = self

        p4PickerView.delegate = self
        p4PickerView.dataSource = self

        p5PickerView.delegate = self
        p5PickerView.dataSource = self

        p6PickerView.delegate = self
        p6PickerView.dataSource = self

        p7PickerView.delegate = self
        p7PickerView.dataSource = self
//
        // priority dropdown stuff
//        periodTF.placeholder = "Select period"
//        periodTF.inputView = periodPickerView
//
//        dayTF.placeholder = "Select day"
//        dayTF.inputView = dayPickerView
//
        period1TF.placeholder = "Select class for period 1"
        period1TF.inputView = p1PickerView
        
        period2TF.placeholder = "Select class for period 2"
        period2TF.inputView = p2PickerView
        
        period3TF.placeholder = "Select class for period 3"
        period3TF.inputView = p3PickerView
        
        period4TF.placeholder = "Select class for period 4"
        period4TF.inputView = p4PickerView
        
        period5TF.placeholder = "Select class for period 5"
        period5TF.inputView = p5PickerView
        
        period6TF.placeholder = "Select class for period 6"
        period6TF.inputView = p6PickerView
        
        period7TF.placeholder = "Select class for period 7"
        period7TF.inputView = p7PickerView
        
        let userController = UserController()
        let classController = ClassController()
        userController.getUserById(id: self.userID){ [self] result in
            switch result {
            case .success(let user):
                print("get user success")
                let userClasses = user.classes
                for cl in userClasses {
                    classController.getClassById(id: cl){ [self] result in
                        switch result {
                        case .success(let classResult):
                            print("get class success", classResult)
                            self.classOptions.append(classResult.class)
                        case .failure(let error):
                            print("get class failed ", error)
                        }
                    }
                }
            case .failure(let error):
                print("get user failed ", error)
            }
        }
    }
    
    // MARK: - UIPickerViewDataSource
    // Number of components in the picker view (columns)
    func numberOfComponents(in periodPickerView: UIPickerView) -> Int {
        return 1
    }

    // MARK: - UIPickerViewDelegate
            
    // Number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.classOptions.count
    }

    // Title for each row in the picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.classOptions[row].className
    }

    // Handle selection in the picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.p1PickerView {
            self.scheduleDataID[self.currentDay][0] = self.classOptions[row]._id
            period1TF.text = self.classOptions[row].className
            period1TF.resignFirstResponder() // Hide the picker view after selection
        } else if pickerView == self.p2PickerView {
            period2TF.text = self.classOptions[row].className
            period2TF.resignFirstResponder() // Hide the picker view after selection
        } else if pickerView == self.p3PickerView {
            period3TF.text = self.classOptions[row].className
            period3TF.resignFirstResponder() // Hide the picker view after selection
        } else if pickerView == self.p4PickerView {
            period4TF.text = self.classOptions[row].className
            period4TF.resignFirstResponder() // Hide the picker view after selection
        }else if pickerView == self.p5PickerView {
            period5TF.text = self.classOptions[row].className
            period5TF.resignFirstResponder() // Hide the picker view after selection
        }else if pickerView == self.p6PickerView {
            period6TF.text = self.classOptions[row].className
            period6TF.resignFirstResponder() // Hide the picker view after selection
        }
        else {
            period7TF.text = self.classOptions[row].className
            period7TF.resignFirstResponder() // Hide the picker view after selection
        }
    }
            
    @IBAction func tappedCreate() {
        // add create stuff
        guard let period1 = period1TF.text,
        let period2 = period2TF.text,
        let period3 = period3TF.text,
        let period4 = period4TF.text,
        let period5 = period5TF.text,
        let period6 = period6TF.text,
        let period7 = period7TF.text else {
           // Handle error if any of the fields is empty
           print("Please fill in all fields.")
           return
           }
//        switch day {
//        case "Day 1":
//            daySelected =
//        default:
//            <#code#>
//        }
        
//        if self.title == "Edit Day" + String(self.currentDay) + " Schedule" {
//            // editing
//            let userController = UserController()
//            let scheduleController = ScheduleController()
//            userController.getUserById(id: self.userID){ [self] result in
//                switch result {
//                case .success(let user):
//                    print("get user success")
//                    scheduleController.getScheduleById(id: user.schedule._id){ [self] result in
//                        switch result {
//                        case .success(let sch):
//                            print("get schedule success/exists")
//                            // edit schedule
//                            // set user schedule
//                        case .failure(let error):
//                            print("get schedule failed/does not exist")
//                            // create schedule
//                            // set user schedule
//                        }
//                    }
//                case .failure(let error):
//                    print("get user failed")
//                }
//            }
//        } else {
//            // creating
//        }
//
        
        self.scheduleData[self.currentDay][0] += period1
        self.scheduleData[self.currentDay][1] += period2
        self.scheduleData[self.currentDay][2] += period3
        self.scheduleData[self.currentDay][3] += period4
        self.scheduleData[self.currentDay][4] += period5
        self.scheduleData[self.currentDay][5] += period6
        self.scheduleData[self.currentDay][6] += period7
        
        DispatchQueue.main.async {
            print("scheduleData before going back to prev vc", self.scheduleData)
            print("changedDays before going back", self.changedDays)
//            let vc = self.storyboard?.instantiateViewController(identifier: "scheInfo") as! ScheduleInfoViewController
//            vc.scheduleData = self.scheduleData
//            if let navigationController = self.navigationController {
//                navigationController.popViewController(animated: true)
//            }
            
            if let navigationController = self.navigationController {
                // Assign the updated scheduleData before popping the view controller
                if let vc = navigationController.viewControllers.first(where: { $0 is ScheduleInfoViewController }) as? ScheduleInfoViewController {
                    vc.scheduleData = self.scheduleData
                    vc.changedDays = self.changedDays
                }
                navigationController.popViewController(animated: true)
            }
        }
    }
    
    // create an event
    func createEvent(title: String, description: String, startDate: Date, endDate: Date, classId: String) {
        // use necessary controllers
        let eventController = EventController()
        let classController = ClassController()
        
        // create new event
        eventController.createEvent(title: title, description: description, startDate: startDate, endDate: endDate) { result in
            switch result {
            case .success(let eventObject):
                print("Event created successfully")
                // add event to class
                classController.addEvent(id: classId, eventId: eventObject.event._id) { [self] result in
                    switch result {
                    case .success(let classObject):
                        print("Event added successfully to class: \(classObject)")
                        // create notification for post
                        self.createNotifForPost(classId: classId, postTitle: eventObject.event.title)
                    case .failure(let error):
                        print("Error adding event: \(error)")
                    }
                }
            case .failure(let error):
                print("Error creating event: \(error)")
            }
        }
    }
    
    // create an assignment
    func createAssignment(title: String, description: String, dueDate: Date, classId: String) {
        // use necessary controllers
        let assignmentController = AssignmentController()
        let classController = ClassController()
        
        // create new assignment
        assignmentController.createAssignment(title: title, description: description, dueDate: dueDate) { result in
            switch result {
            case .success(let assignmentObject):
                print("Assignment created successfully")
                // add assignment to class
                classController.addAssignment(id: classId, assignmentId: assignmentObject.assignment._id) { result in
                    switch result {
                    case .success(let classObject):
                        print("Assignment added successfully to class: \(classObject)")
                        // create notification for post
                        self.createNotifForPost(classId: classId, postTitle: assignmentObject.assignment.title)
                    case .failure(let error):
                        print("Error adding assignment: \(error)")
                    }
                }
            case .failure(let error):
                print("Error creating assignment: \(error)")
            }
        }
    }
    
    // create an alert
    func createAlert(title: String, description: String, priority: String, classId: String) {
        // use necessary controllers
        let alertController = AlertController()
        let classController = ClassController()
        
        // create new alert
        alertController.createAlert(title: title, description: description, priority: priority) { result in
            switch result {
            case .success(let alertObject):
                print("Alert created successfully")
                // add alert to class
                classController.addAlert(id: classId, alertId: alertObject.alert._id) { result in
                    switch result {
                    case .success(let classObject):
                        print("Assignment added successfully to class: \(classObject)")
                        // create notification for post
                        self.createNotifForPost(classId: classId, postTitle: alertObject.alert.title)
                    case .failure(let error):
                        print("Error adding alert: \(error)")
                    }
                }
            case .failure(let error):
                print("Error creating alert: \(error)")
            }
        }
    }
    
    // create notification for a post and add to notifications of each class member
    func createNotifForPost(classId: String, postTitle: String) {
        // use necessary controllers
        let classController = ClassController()
        let userController = UserController()
        let notificationController = NotificationController()

        // get class by id
        classController.getClassById(id: classId) { result in
            switch result {
            case .success(let classObject):
                print("Class retrieved successfully: \(classObject)")
                
                // get class users and name
                let users = classObject.class.users
                let className = classObject.class.className
                
                // create a notification for the class post
                notificationController.createNotification(className: className, title: postTitle) { result in
                    switch result {
                    case .success(let notificationObject):
                        // loop through users and add notification for each user
                        print("Notification created successfully: \(notificationObject)")
                        for user in users {
                            print("user ", user)
                            userController.addNotification(id: user, notificationId: notificationObject.notification._id) { result in
                                switch result {
                                case .success(let userObject):
                                    print("Notification added successfully for user \(userObject)")
                                case .failure(let error):
                                    print("Error adding notification \(error)")
                                }
                            }
                        }
                    case .failure(let error):
                        print("Error creating notification: \(error)")
                    }
                }
            case .failure(let error):
                print("Error retrieving class: \(error)")
                return
            }
        }
    }
}