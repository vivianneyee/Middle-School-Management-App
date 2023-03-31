//
//  ViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-03-13.
//

import UIKit

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

class NotificationPrefViewController: UIViewController {
    
    @IBOutlet var switchNotif: UISwitch!
    @IBOutlet var switchEvents: UISwitch!
    @IBOutlet var switchAssignments: UISwitch!
    @IBOutlet var switchAlerts: UISwitch!
    @IBOutlet var switchContent: UISwitch!
    
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

