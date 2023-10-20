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
