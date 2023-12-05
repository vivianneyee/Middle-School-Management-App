//
//  JoinClassViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

class JoinClassViewController: UIViewController {
    var userID: String = ""
    @IBOutlet var field: UITextField!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("userid join class vc: ", self.userID)
    }
    
    @IBAction func tappedSubmit() {
        // add submit stuff
        guard let classCode = field.text else {
        // Handle error if any of the fields is empty
        print("Please fill in all fields.")
        return
        }
        joinClassWithCode(userId: self.userID, classCode: classCode)
//        let userController = UserController()
//        userController.joinClass(id: self.userID, classId: classCode) { [self] result in
//            switch result {
//            case .success(let resData2):
//                print("join class successful")
//                print(resData2)
//                DispatchQueue.main.async {
//                    let alert = UIAlertController(title: "Successfully joined new class", message: "Joined class "+classCode, preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: "Close", style: .default)
//                    alert.addAction(okAction)
//                    self.present(alert, animated: true, completion: nil)
//                }
//            case .failure(let error):
//                print("join class failed with error: \(error)")
//                DispatchQueue.main.async {
//                    let alert = UIAlertController(title: "Failed to join new class", message: "Could not join class "+classCode+". Please try again later.", preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: "Close", style: .default)
//                    alert.addAction(okAction)
//                    self.present(alert, animated: true, completion: nil)
//                }
//            }
//        }
    }
    
    func joinClassWithCode(userId: String, classCode: String) {
        let classController = ClassController()
        let userController = UserController()
        
        classController.getClassByCode(code: classCode) { result in
            switch result {
            case .success(let classObject):
                print("Class retrieved successfully: \(classObject.class.className)")
                userController.joinClass(id: userId, classId: classObject.class._id) { result in
                    switch result {
                    case .success(let userObject):
                        print("Class joined successfully: \(userObject)")
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Successfully joined new class", message: "Joined class "+classObject.class.className, preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Close", style: .default)
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    case .failure(let error):
                        print("Could not join class: \(error)")
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Failed to join new class", message: "Could not join class "+classObject.class.className+". Please try again later.", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Close", style: .default)
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            case .failure(let error):
                print("Error retrieving class: \(error)")
            }
        }
    }
}
