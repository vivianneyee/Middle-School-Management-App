//
//  NotificationPrefViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift


class NotificationPrefViewController: UITableViewController {
    
    @IBOutlet var switchNotif: UISwitch!
    @IBOutlet var switchEvents: UISwitch!
    @IBOutlet var switchAssignments: UISwitch!
    @IBOutlet var switchAlerts: UISwitch!
    @IBOutlet var switchContent: UISwitch!
    
    @IBOutlet weak var table: UITableView!
    
    // UserDefaults keys for storing notification preferences
       let notifPrefKey = "notifPref"
       let eventsPrefKey = "eventsPref"
       let assignmentsPrefKey = "assignmentsPref"
       let alertsPrefKey = "alertsPref"
       let contentPrefKey = "contentPref"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notification Preferences"
        
        // Load initial switch states from UserDefaults
        switchNotif.isOn = UserDefaults.standard.bool(forKey: notifPrefKey)
        switchEvents.isOn = UserDefaults.standard.bool(forKey: eventsPrefKey)
        switchAssignments.isOn = UserDefaults.standard.bool(forKey: assignmentsPrefKey)
        switchAlerts.isOn = UserDefaults.standard.bool(forKey: alertsPrefKey)
        switchContent.isOn = UserDefaults.standard.bool(forKey: contentPrefKey)
            
    }
    
    // Function to update UserDefaults and handle notification logic
    func updateNotificationPreference(switch: UISwitch, key: String) {
        UserDefaults.standard.set(`switch`.isOn, forKey: key)

        // TODO: Implement notification logic based on the switch state
        if `switch`.isOn {
            // Enable notifications for the specified type
            print("Enable notifications for \(key)")
        } else {
            // Disable notifications for the specified type
            print("Disable notifications for \(key)")
        }
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
