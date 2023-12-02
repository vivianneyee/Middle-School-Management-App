//
//  CreateEventViewController.swift
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
class CreateEventViewController: UIViewController {
    @IBOutlet weak var enddateTF: UITextField!
    @IBOutlet weak var startdateTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTF: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var className: String = ""
    var userID: String = ""
    var classID: String = ""
    var eventID: String = ""
    var eventName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.title == "Edit " + self.eventName {
            button.setTitle("Update", for: .normal)
            let eventController = EventController()
            eventController.getEventById(id: self.eventID) { [self] result in
                switch result {
                case .success(let dataResponse):
                    print("get event success")
                    DispatchQueue.main.async {
                        let isoDateFormatter = ISO8601DateFormatter()
                        if let date = isoDateFormatter.date(from: dataResponse.event.startDate) {
                            let outputDateFormatter = DateFormatter()
                            outputDateFormatter.dateFormat = "MMMM d yyyy"
                            let formattedDate = outputDateFormatter.string(from: date)
                            self.startdateTF.text = formattedDate
                        }
                        
                        if let date = isoDateFormatter.date(from: dataResponse.event.endDate) {
                            let outputDateFormatter = DateFormatter()
                            outputDateFormatter.dateFormat = "MMMM d yyyy"
                            let formattedDate = outputDateFormatter.string(from: date)
                            self.enddateTF.text = formattedDate
                        }

                        self.titleTF.text = dataResponse.event.title
                        self.descTF.text = dataResponse.event.description
                    }
                case .failure(let error):
                    print("get ass failed")
                }
            }
        } else {
            button.setTitle("Create", for: .normal)
            startdateTF.text = ""
            enddateTF.text = ""
            titleTF.text = ""
            descTF.text = ""
        }
        
        // date picker stuff
        let startDatePicker = UIDatePicker()
        startDatePicker.datePickerMode = .date
        startDatePicker.addTarget(self, action: #selector(startDateChange(datePicker:)), for: UIControl.Event.valueChanged)
        startDatePicker.frame.size = CGSize(width: 0, height: 300)
        startDatePicker.preferredDatePickerStyle = .wheels
        
        let endDatePicker = UIDatePicker()
        endDatePicker.datePickerMode = .date
        endDatePicker.addTarget(self, action: #selector(endDateChange(datePicker:)), for: UIControl.Event.valueChanged)
        endDatePicker.frame.size = CGSize(width: 0, height: 300)
        endDatePicker.preferredDatePickerStyle = .wheels
        
        startdateTF.inputView = startDatePicker
        enddateTF.inputView = endDatePicker
        
        startdateTF.text = formatDate(date: Date())
        enddateTF.text = formatDate(date: Date())
    }
    
    @objc func startDateChange(datePicker: UIDatePicker) {
        startdateTF.text = formatDate(date: datePicker.date)
    }
    @objc func endDateChange(datePicker: UIDatePicker) {
        enddateTF.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
    }
    
    @IBAction func tappedCreate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"

        guard let title = titleTF.text,
              let desc = descTF.text,
              let startDate = formatter.date(from: startdateTF.text!),
              let endDate = formatter.date(from: enddateTF.text!) else {
            // Handle error if any of the fields is empty
            print("Please fill in all fields.")
            return
        }
        if button.title(for: .normal) == "Update" {
            // use necessary controllers
            let eventController = EventController()
            let classController = ClassController()
            
            // create new event
            eventController.updateEvent(id: self.eventID, title: title, description: description, startDate: startDate, endDate: endDate) { result in
                switch result {
                case .success(let eventObject):
                    print("Event created successfully")
//                    // add event to class
//                    print("classId ", classId, " eventObject.event._id ", eventObject.event._id)
//                    classController.addEvent(id: classId, eventId: eventObject.event._id) { [self] result in
//                        switch result {
//                        case .success(let classObject):
//                            print("Event added successfully to class: \(classObject)")
//                            // create notification for post
//                            self.createNotifForPost(classId: classId, postTitle: eventObject.event.title)
//                        case .failure(let error):
//                            print("Error adding event: \(error)")
//                        }
//                    }
                case .failure(let error):
                    print("Error creating event: \(error)")
                }
            }
            DispatchQueue.main.async {
                if let navigationController = self.navigationController {
                    navigationController.popViewController(animated: true)
                }
            }
        } else {
            createEvent(title: title, description: desc, startDate: startDate, endDate: endDate, classId: self.classID)
            DispatchQueue.main.async {
                if let navigationController = self.navigationController {
                    navigationController.popViewController(animated: true)
                }
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
                print("classId ", classId, " eventObject.event._id ", eventObject.event._id)
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
