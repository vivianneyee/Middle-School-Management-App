//
//  CreatePostViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

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
                classController.addEvent(id: classId, eventId: eventObject._id) { result in
                    switch result {
                    case .success(let classObject):
                        print("Event added successfully to class: \(classObject)")
                        // create notification for post
                        self.createNotifForPost(classId: classId, postTitle: eventObject.title)
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
                classController.addAssignment(id: classId, assignmentId: assignmentObject._id) { result in
                    switch result {
                    case .success(let classObject):
                        print("Assignment added successfully to class: \(classObject)")
                        // create notification for post
                        self.createNotifForPost(classId: classId, postTitle: assignmentObject.title)
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
                classController.addAssignment(id: classId, assignmentId: alertObject._id) { result in
                    switch result {
                    case .success(let classObject):
                        print("Assignment added successfully to class: \(classObject)")
                        // create notification for post
                        self.createNotifForPost(classId: classId, postTitle: alertObject.title)
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
                let users = classObject.users
                let className = classObject.className
                
                // create a notification for the class post
                notificationController.createNotification(className: className, title: postTitle) { result in
                    switch result {
                    case .success(let notificationObject):
                        // loop through users and add notification for each user
                        print("Notification created successfully: \(notificationObject)")
                        for user in users {
                            userController.addNotification(id: user._id, notificationId: notificationObject._id) { result in
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
