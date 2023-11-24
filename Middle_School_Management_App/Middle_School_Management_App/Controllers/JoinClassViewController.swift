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
    }
    
    @IBAction func tappedSubmit() {
        // add submit stuff
    }
    
    func joinClassWithCode(userId: String, classCode: String) {
        let classController = ClassController()
        let userController = UserController()
        
        classController.getClassByCode(code: classCode) { result in
            switch result {
            case .success(let classObject):
                print("Class retrieved successfully: \(classObject.className)")
                userController.joinClass(id: userId, classId: classObject._id) { result in
                    switch result {
                    case .success(let userObject):
                        print("Class joined successfully: \(userObject)")
                    case .failure(let error):
                        print("Could not join class: \(error)")
                    }
                }
            case .failure(let error):
                print("Error retrieving class: \(error)")
            }
        }
    }
}
