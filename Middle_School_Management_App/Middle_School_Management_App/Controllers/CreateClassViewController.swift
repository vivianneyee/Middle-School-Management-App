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
        let colourString = selectedColour.hexString
        classController.createClass(className: className, color: colourString) { result in
            switch result {
            case .success(let data):
                print("registration successful")
            case .failure(let error):
                print ("Registration failed with error: \(error)")
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
