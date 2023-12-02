//
//  EditViewController.swift
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
// code functionality later...
class EditViewController: UIViewController {
    
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    var postTitle: String?
    var postDate: String?
    var userID: String = ""
    var classID: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = .date
//        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
//        datePicker.frame.size = CGSize(width: 0, height: 300)
//        datePicker.preferredDatePickerStyle = .wheels
//
//        dateTF.inputView = datePicker
//
//        for (index, event) in eventData.enumerated() {
//            if "Edit " + event.name == title {
//                let date = Calendar.current.date(from: eventData[index].date)
//                let formatter = DateFormatter()
//                formatter.dateFormat = "MMMM dd yyyy"
//                dateTF.text = formatter.string(from : date!)
//
//                titleTF.text = event.name
//            }
//        }
//
//        for (index, assign) in assignData.enumerated() {
//            if "Edit " + assign.name == title {
//                let date = Calendar.current.date(from: assignData[index].date)
//                let formatter = DateFormatter()
//                formatter.dateFormat = "MMMM dd yyyy"
//                dateTF.text = formatter.string(from : date!)
//                
//                titleTF.text = assign.name
//            }
//        }
//        
//        for (index, alert) in alertData.enumerated() {
//            if "Edit " + alert.name == title {
//                print(true)
//                let date = Calendar.current.date(from: alertData[index].date)
//                let formatter = DateFormatter()
//                formatter.dateFormat = "MMMM dd yyyy"
//                dateTF.text = formatter.string(from : date!)
//                
//                titleTF.text = alertData[index].name
//                
//            }
//        }
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        dateTF.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
    }
    
    @IBAction func tappedSave() {
        // add save stuff
    }
}
