//
//  CustomTabBarController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-11-23.
//
import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift


class CustomTabBarController: UITabBarController {
    
    var userID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Access each view controller in the tab bar and pass the data
        if let viewControllers = self.viewControllers {
            for viewController in viewControllers {
                if let firstVC = viewController as? NotificationsViewController {
                    firstVC.userID = userID
                } else if let secondVC = viewController as? ScheduleViewController {
                    secondVC.userID = userID
                } else if let thirdVC = viewController as? ClassesViewController {
                    thirdVC.userID = userID
                } else if let fourthVC = viewController as? JoinClassViewController {
                    fourthVC.userID = userID
                } else if let fifthVC = viewController as? ProfileViewController {
                    fifthVC.userID = userID
                }
            }
        }
        
    }
}
