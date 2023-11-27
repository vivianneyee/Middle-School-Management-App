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
        print("userID after login: ", self.userID)
        // Access each view controller in the tab bar and pass the data
        if let viewControllers = self.viewControllers {
            for viewController in viewControllers {
                if let navController = viewController as? UINavigationController {
                    if let firstVC = navController.viewControllers.first as? NotificationsViewController {
                        firstVC.userID = self.userID
                    } else if let secondVC = navController.viewControllers.first as? ScheduleViewController {
                        secondVC.userID = self.userID
                    } else if let thirdVC = navController.viewControllers.first as? ClassesViewController {
                        thirdVC.userID = self.userID
                    } else if let fourthVC = navController.viewControllers.first as? JoinClassViewController {
                        fourthVC.userID = self.userID
                    } else if let fifthVC = navController.viewControllers.first as? ProfileViewController {
                        fifthVC.userID = self.userID
                    }
                }
            }
            
        }
    }
}
