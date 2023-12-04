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
    var day1Sche: [String] = ["","","","","","",""]
    var day2Sche: [String] = ["","","","","","",""]
    var day3Sche: [String] = ["","","","","","",""]
    var day4Sche: [String] = ["","","","","","",""]
    var day5Sche: [String] = ["","","","","","",""]
    var day6Sche: [String] = ["","","","","","",""]
    var day7Sche: [String] = ["","","","","","",""]
    var day8Sche: [String] = ["","","","","","",""]
    var day9Sche: [String] = ["","","","","","",""]
    var day10Sche: [String] = ["","","","","","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("userID after login: ", self.userID)
        let userController = UserController()
        let scheduleController = ScheduleController()
            // creating
        
//        userController.getUserById(id: self.userID){ [self] result in
//            switch result {
//            case .success(let dataResponse):
//                print("got user", dataResponse)
//                if dataResponse.schedule.isEmpty {
//                    scheduleController.createSchedule(day1: self.day1Sche, day2: self.day2Sche, day3: self.day3Sche, day4: self.day4Sche, day5: self.day5Sche, day6: self.day6Sche, day7: self.day7Sche, day8: self.day8Sche, day9: self.day9Sche, day10: self.day10Sche){ [self] result in
//                        switch result {
//                        case .success(let dataResponse):
//                            print("Created schedule successully ", dataResponse)
//                            userController.setSchedule(id: self.userID, scheduleId: dataResponse._id) { [self] result in
//                                switch result {
//                                case .success(let dataResponse):
//                                    print("successfully set schedule to user", dataResponse)
//                                case .failure(let error):
//                                    print("failed to set schedule to user", error)
//                                }
//                            }
//                        case .failure(let error):
//                            print("failed to create schedule: ", error)
//                        }
//                    }
//                }
//            case .failure(let error):
//                print("error getitgn user", error)
//            }
//        }
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
