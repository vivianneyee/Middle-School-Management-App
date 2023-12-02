//
//  CreateClassViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

class CreateClassViewController: UIViewController {
    var userID: String = ""

    @IBOutlet var field: UITextField!
    @IBOutlet var colour: UIColorWell!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create New Class"
    }
    
    
    @IBAction func tappedSubmit() {
        
        guard let className = field.text, !className.isEmpty else {
            // Handle case when the field is empty
            print("Please enter a class name")
            return
        }
        
        guard let selectedColour = colour.selectedColor else {
            // Handle case when selected color is nil
            print("Please select a color")
            return
        }

        // add submit stuff
        let classController = ClassController()
        let userController = UserController()
        let colourString = selectedColour.hexString
        classController.createClass(className: className, color: colourString) { [self] result in
            switch result {
            case .success(let resData1):
                print("create class successful")
                print(resData1)
                classController.addUser(id: resData1.newClass._id, userId: self.userID) { [self] result in
                    switch result {
                    case .success(let resData2):
                        print("add user successful")
//                        DispatchQueue.main.async {
//                            if let navigationController = self.navigationController {
//                                navigationController.popViewController(animated: true)
//                            }
//                        }
                        userController.joinClass(id: self.userID, classId: resData1.newClass._id) { [self] result in
                            switch result {
                            case .success(let resData2):
                                print("join class after create class successful")
                                print(resData2)
                                DispatchQueue.main.async {
                                    if let navigationController = self.navigationController {
                                        navigationController.popViewController(animated: true)
                                    }
                                }
                            case .failure(let error):
                                print("join class after create class failed with error: \(error)")
                            }
                        }
                    case .failure(let error):
                        print("add user to class failed with error: \(error)")
                    }
                }
                
            case .failure(let error):
                print ("create class failed with error: \(error)")
            }
        }
    }
    
}

extension UIColor {
    var hexString: String {
        guard let components = self.cgColor.components, components.count >= 3 else {
            return "#FFFFFF" // Default to white color if unable to get components
        }

        let red = Int(components[0] * 255.0)
        let green = Int(components[1] * 255.0)
        let blue = Int(components[2] * 255.0)

        return String(format: "#%02lX%02lX%02lX", red, green, blue)
    }
}
