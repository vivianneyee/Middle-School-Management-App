//
//  ProfileViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

class ProfileViewController: UIViewController {
    var userID: String = ""
    @IBAction func tapToSettings(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "settings") as! SettingsViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapToNotifPref(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "notifpref") as! NotificationPrefViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapToLogin(_ sender: Any) {
       let vc = storyboard?.instantiateViewController(identifier: "login") as! LoginViewController
//       navigationController?.pushViewController(vc, animated: true)
       // add sign out logic
       vc.modalPresentationStyle = .fullScreen  // Optional: Set the presentation style
       present(vc, animated: true, completion: nil)
   }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}
