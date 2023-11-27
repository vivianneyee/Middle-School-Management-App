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
    var userID: String = "default"
    
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
