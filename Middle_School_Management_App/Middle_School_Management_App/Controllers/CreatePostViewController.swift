//
//  CreatePostViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

// EVENT, ASSIGNMENT, ALERT
class CreatePostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var priorityTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTF: UITextField!
    
    var className: String = ""
    
    // Array of options for the priority dropdown
    let priorityOptions = ["Low", "Medium", "High"]

    
    // Picker view for the dropdown options
    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        
        // date picker stuff
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTF.inputView = datePicker
        
        dateTF.text = formatDate(date: Date())
        
        // priority dropdown stuff
        priorityTF.placeholder = "Select option"
        priorityTF.inputView = pickerView
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        dateTF.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
    }
    
    // MARK: - UIPickerViewDataSource

    // Number of components in the picker view (columns)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // Number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorityOptions.count
    }

    // MARK: - UIPickerViewDelegate

    // Title for each row in the picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorityOptions[row]
    }

    // Handle selection in the picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priorityTF.text = priorityOptions[row]
        priorityTF.resignFirstResponder() // Hide the picker view after selection
    }
    
    @IBAction func tappedCreate() {
        // add create stuff
        if self.title == "Create New Alert" {
            
            guard let title = titleTF.text,
               let desc = descTF.text,
               let priority = priorityTF.text else {
               // Handle error if any of the fields is empty
               print("Please fill in all fields.")
               return
               }
        // call function to create new alert
            // CHANGE THIS TO PASS THE ACTUAL CLASS OBJECT
            let classObj = Class(name: self.className, color: UIColor.red.hexString, code: "1111")
            let realm = try! Realm() // Instantiate a Realm instance
            let postController = PostContoller(realm: realm)

            let result = postController.createAlert(classObj: classObj, title: title, desc: desc, priority: priority)
//            if result != nil {
//                print("new alert created successfully")
//            } else {
//                print ("New alert failed with error: \(error)")
//            }
//            { result in
//                switch result {
//                case .success(let data):
//                    print("new alert created successfully")
//                case .failure(let error):
//                    print ("New alert failed with error: \(error)")
//                }
//            }
        } else {
            print("No title set for this view controller.")
        }
    }
    
}
