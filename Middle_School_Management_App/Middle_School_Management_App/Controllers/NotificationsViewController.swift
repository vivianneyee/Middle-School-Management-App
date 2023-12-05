//
//  NotificationsViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift
import UserNotifications


class NotificationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UNUserNotificationCenterDelegate {
    @IBOutlet weak var table: UITableView!
    var userID: String = ""
    var allNotifs: [Notification] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Request user permission for notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
        UNUserNotificationCenter.current().delegate = self

        //        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        table.dataSource = self
        table.delegate = self
        print("notif page userID: ", self.userID)
        
        let userController = UserController()
        let classContoller = ClassController()
        let notifController = NotificationController()
        let alertController = AlertController()
        let eventController = EventController()
        let assController = AssignmentController()
        self.allNotifs.removeAll()
//         get user by id
        userController.getUserById(id: self.userID){ [self] result in
            switch result {
            case .success(let dataResponse):
                print("get user success")
                for n in dataResponse.notifications {
                    notifController.getNotificationById(id: n) { [self] result in
                        switch result {
                        case .success(let dataResponse):
                            print("get notif success")
                            self.allNotifs.append(dataResponse.notification)
                            DispatchQueue.main.async {
                                print("self.allNotifs", self.allNotifs)
                                self.table.reloadData()
                            }
                        case .failure(let error):
                            print("get notif failed", error)
                        }
                        
                    }
                }
            case .failure(let error):
                print("get user failure")
            }
        }
        
        
//        // get user by id
//        userController.getUserById(id: self.userID){ [self] result in
//            switch result {
//            case .success(let dataResponse):
//                print("Login successful")
//
//                    print(dataResponse)
//                    print(dataResponse._id)
//                    print("classes", dataResponse.classes)
//                // iterate through user's classes
//                for c in dataResponse.classes {
//                    classContoller.getClassById(id: c){ [self] result in
//                        switch result {
//                        case .success(let dataResponse):
//                            var classTitle = dataResponse.class.className
//                            print(dataResponse)
//                            // for each class, go through each alert
//                            for al in dataResponse.class.alerts {
//                                alertController.getAlertById(id: al) { [self] result in
//                                    switch result {
//                                    case .success(let dataResponse):
//                                        print(dataResponse)
//                                        notifController.createNotification(className: classTitle, title: dataResponse.title ) { [self] result in
//                                            switch result {
//                                            case .success(let dataResponse):
//                                                print(dataResponse)
//                                                // create a new notification object for each one and append to the allNotifs array
//                                                let newNotif = Notification(_id: dataResponse._id, className: dataResponse.className, title: dataResponse.title, datePosted: dataResponse.datePosted)
////                                                self.allNotifs.append(newNotif)
//                                            case .failure(let error):
//                                                print("error", error)
//                                            }
//                                        }
//                                    case .failure(let error):
//                                        print("error", error)
//                                    }
//                                }
//                                DispatchQueue.main.async {
//                                    self.table.reloadData()
//                                }
//                            }
//                            // for each class, go through each event
//                            for ev in dataResponse.class.events {
//                                eventController.getEventById(id: ev) { [self] result in
//                                    switch result {
//                                    case .success(let dataResponse):
//                                        print(dataResponse)
//                                        notifController.createNotification(className: classTitle, title: dataResponse.title ) { [self] result in
//                                            switch result {
//                                            case .success(let dataResponse):
//                                                print(dataResponse)
//                                                // create a new notification object for each one and append to the allNotifs array
//                                                let newNotif = Notification(_id: dataResponse._id, className: dataResponse.className, title: dataResponse.title, datePosted: dataResponse.datePosted)
//                                                self.allNotifs.append(newNotif)
//                                            case .failure(let error):
//                                                print("error", error)
//                                            }
//                                        }
//                                    case .failure(let error):
//                                        print("error", error)
//                                    }
//                                }
//                                DispatchQueue.main.async {
//                                    self.table.reloadData()
//                                }
//                            }
//                            // for each class, go through each assignment
//                            for ass in dataResponse.class.assignments {
//                                assController.getAssignmentById(id: ass) { [self] result in
//                                    switch result {
//                                    case .success(let dataResponse):
//                                        print(dataResponse)
//                                        notifController.createNotification(className: classTitle, title: dataResponse.title ) { [self] result in
//                                            switch result {
//                                            case .success(let dataResponse):
//                                                print(dataResponse)
//                                                // create a new notification object for each one and append to the allNotifs array
//                                                let newNotif = Notification(_id: dataResponse._id, className: dataResponse.className, title: dataResponse.title, datePosted: dataResponse.datePosted)
//                                                self.allNotifs.append(newNotif)
//                                            case .failure(let error):
//                                                print("error", error)
//                                            }
//                                        }
//                                    case .failure(let error):
//                                        print("error", error)
//                                    }
//                                }
//                                for n in allNotifs {
//                                    userController.addNotification(id: self.userID, notificationId: n._id) { [self] result in
//                                        switch result {
//                                        case .success(let dataResponse):
//                                            print(dataResponse)
//                                        case .failure(let error):
//                                            print ("add notif to user failed with error: \(error)")
//                                        }
//                                    }
//                                }
//                                DispatchQueue.main.async {
//                                    self.table.reloadData()
//                                }
//                            }
//
//                        case .failure(let error):
//                            print ("get classes failed with error: \(error)")
//                        }
//                        //                    self.data = dataResponse.classes
//                    }
//                }
//            case .failure(let error):
//                print ("get classes failed with error: \(error)")
//            }
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userController = UserController()
        let classContoller = ClassController()
        let notifController = NotificationController()
        let alertController = AlertController()
        let eventController = EventController()
        let assController = AssignmentController()
      self.allNotifs.removeAll()
        DispatchQueue.main.async {
            self.table.reloadData()
        }
        userController.getUserById(id: self.userID){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dataResponse):
                print("get user success")
                for n in dataResponse.notifications {
                    notifController.getNotificationById(id: n) { [self] result in
                        switch result {
                        case .success(let dataResponse):
                            print("get notif success")
                            self.allNotifs.append(dataResponse.notification)
                            DispatchQueue.main.async {
                                print("self.allNotifs", self.allNotifs)
                                self.table.reloadData()
                            }
                        case .failure(let error):
                            print("get notif failed", error)
                        }
                        
                    }
                }
            case .failure(let error):
                print("get user failure")
            }
        }
        DispatchQueue.main.async {
            self.table.reloadData()
        }
//        // get user by id
//        userController.getUserById(id: self.userID){ [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let dataResponse):
//                print("Login successful")
//
//                    print(dataResponse)
//                    print(dataResponse._id)
//                    print("classes", dataResponse.classes)
//                // iterate through user's classes
//                for c in dataResponse.classes {
//                    classContoller.getClassById(id: c){ [self] result in
//                        switch result {
//                        case .success(let dataResponse):
//                            var classTitle = dataResponse.class.className
//                            print(dataResponse)
//                            // for each class, go through each alert
//                            for al in dataResponse.class.alerts {
//                                alertController.getAlertById(id: al) { [self] result in
//                                    switch result {
//                                    case .success(let dataResponse):
//                                        print(dataResponse)
//                                        notifController.createNotification(className: classTitle, title: dataResponse.title ) { [self] result in
//                                            switch result {
//                                            case .success(let dataResponse):
//                                                print(dataResponse)
//                                                // create a new notification object for each one and append to the allNotifs array
//                                                let newNotif = Notification(_id: dataResponse._id, className: dataResponse.className, title: dataResponse.title, datePosted: dataResponse.datePosted)
//                                                self.allNotifs.append(newNotif)
//                                            case .failure(let error):
//                                                print("error", error)
//                                            }
//                                        }
//                                    case .failure(let error):
//                                        print("error", error)
//                                    }
//                                }
//                                DispatchQueue.main.async {
//                                    self.table.reloadData()
//                                }
//                            }
//                            // for each class, go through each event
//                            for ev in dataResponse.class.events {
//                                eventController.getEventById(id: ev) { [self] result in
//                                    switch result {
//                                    case .success(let dataResponse):
//                                        print(dataResponse)
//                                        notifController.createNotification(className: classTitle, title: dataResponse.title ) { [self] result in
//                                            switch result {
//                                            case .success(let dataResponse):
//                                                print(dataResponse)
//                                                // create a new notification object for each one and append to the allNotifs array
//                                                let newNotif = Notification(_id: dataResponse._id, className: dataResponse.className, title: dataResponse.title, datePosted: dataResponse.datePosted)
//                                                self.allNotifs.append(newNotif)
//                                            case .failure(let error):
//                                                print("error", error)
//                                            }
//                                        }
//                                    case .failure(let error):
//                                        print("error", error)
//                                    }
//                                }
//                                DispatchQueue.main.async {
//                                    self.table.reloadData()
//                                }
//                            }
//                            // for each class, go through each assignment
//                            for ass in dataResponse.class.assignments {
//                                assController.getAssignmentById(id: ass) { [self] result in
//                                    switch result {
//                                    case .success(let dataResponse):
//                                        print(dataResponse)
//                                        notifController.createNotification(className: classTitle, title: dataResponse.title ) { [self] result in
//                                            switch result {
//                                            case .success(let dataResponse):
//                                                print(dataResponse)
//                                                // create a new notification object for each one and append to the allNotifs array
//                                                let newNotif = Notification(_id: dataResponse._id, className: dataResponse.className, title: dataResponse.title, datePosted: dataResponse.datePosted)
//                                                self.allNotifs.append(newNotif)
//                                            case .failure(let error):
//                                                print("error", error)
//                                            }
//                                        }
//                                    case .failure(let error):
//                                        print("error", error)
//                                    }
//                                }
//                                for n in self.allNotifs {
//                                    userController.addNotification(id: self.userID, notificationId: n._id) { [self] result in
//                                        switch result {
//                                        case .success(let dataResponse):
//                                            print(dataResponse)
//                                        case .failure(let error):
//                                            print ("add notif to user failed with error: \(error)")
//                                        }
//                                    }
//                                }
//                                DispatchQueue.main.async {
//                                    self.table.reloadData()
//                                }
//                            }
//
//                        case .failure(let error):
//                            print ("get classes failed with error: \(error)")
//                        }
//                        //                    self.data = dataResponse.classes
//                    }
//                }
//            case .failure(let error):
//                print ("get classes failed with error: \(error)")
//            }
//        }
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
        
//        // Create an instance of Calendar
//        let calendar = Calendar.current
//
//        // Extract components from the Date
//        let date = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: eventCell.datePosted)
//        let date = Calendar.current.date(from: eventCell.datePosted)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        
        
//        cell.date.text = formatter.string(from : eventCell.datePosted)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: eventCell.datePosted) {
            dateFormatter.dateFormat = "MMMM dd yyyy"
            let formattedDate = dateFormatter.string(from: date)
            cell.date.text = formattedDate
        } else {
            cell.date.text = eventCell.datePosted
        }
        cell.className.text = eventCell.className
        
        cell.notif.text = eventCell.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let notifsCell = self.allNotifs[indexPath.row]
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: notifsCell.className + " - " + notifsCell.title, message: "Date posted: " + notifsCell.datePosted, preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "Close", style: .default)
//            alert.addAction(okAction)
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
//
    // UserDefaults key for storing notification preferences
    let notificationPreferenceKey = "isNotificationsEnabled"

    // Function to register or unregister for push notifications
    func updateNotificationStatus() {
        let isNotificationsEnabled = UserDefaults.standard.bool(forKey: notificationPreferenceKey)

        if isNotificationsEnabled {
            // Register for push notifications
            // Implement your push notification registration logic here
        } else {
            // Unregister for push notifications
            // Implement your push notification unregistration logic here
        }
    }

    // Function to toggle notification preference
    func toggleNotificationPreference() {
        var isNotificationsEnabled = UserDefaults.standard.bool(forKey: notificationPreferenceKey)
        isNotificationsEnabled.toggle()
        UserDefaults.standard.set(isNotificationsEnabled, forKey: notificationPreferenceKey)

        // Update notification registration status
        updateNotificationStatus()
    }

    // Example of calling the toggle function when the user interacts with the switch
    @IBAction func notificationSwitchValueChanged(_ sender: UISwitch) {
        toggleNotificationPreference()
    }

}
