//
//  SettingsViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

class SettingsViewController: UIViewController {
    
    @IBOutlet var changePassButton: UIButton!
    @IBOutlet var editScheButton: UIButton!
    @IBOutlet var manageClassesButton: UIButton!
    @IBOutlet var deleteAccButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
//        do {
//            let realm = try Realm()
//
//            // for debugging
//            print(Realm.Configuration.defaultConfiguration.fileURL!)
//        } catch let error as NSError {
//            print("Error initializing Realm: \(error.localizedDescription)")
//        }
        
        // Add the action for the change password button
        changePassButton.addTarget(self, action: #selector(changePasswordTapped), for: .touchUpInside)
        
        // Add the action for the edit schedule button
        editScheButton.addTarget(self, action: #selector(editScheTapped), for: .touchUpInside)
    }
    
    func weekViewDidClickOnEvent(_ weekView: ECWeekView, event: ECWeekViewEvent, view: UIView) {
        //        eventDetailLauncher.event = event
        //        eventDetailLauncher.present()
    }
    
    func weekViewDidClickOnFreeTime(_ weekView: ECWeekView, date: DateInRegion) {
        print(#function, "date:", date.toString())
    }

//    func createClass(realm: Realm, name: String, color: String) {
//        let code = generateClassCode(realm: realm)
//        let newClass = Class(name: name, color: color, code: code)
//        try! realm.write {
//             realm.add(newClass)
//        }
//    }
//
//    // generate random 6-character code made up of 3 letters and 3 numbers
//    func generateCode() -> String {
//        var code = ""
//        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
//        let nums = "1234567890"
//        for _ in 0..<3 {
//            let letterIndex = Int.random(in: 0..<letters.count)
//            code.append(letters[letters.index(letters.startIndex, offsetBy: letterIndex)])
//        }
//        for _ in 0..<3 {
//            let numIndex = Int.random(in: 0..<nums.count)
//            code.append(nums[nums.index(nums.startIndex, offsetBy: numIndex)])
//        }
//
//        return code
//    }
//
//    // use generateCode() to create a random class code and ensure it is not already in use
//    func generateClassCode(realm: Realm) -> String {
//        var code = generateCode()
//        while realm.objects(Class.self).filter("code == %@", code).count > 0 {
//            code = generateCode()
//        }
//        return code
//    }
//
//    func weekViewDidClickOnEvent(_ weekView: ECWeekView, event: ECWeekViewEvent, view: UIView) {
//        //        eventDetailLauncher.event = event
//        //        eventDetailLauncher.present()
//    }
//
//    func weekViewDidClickOnFreeTime(_ weekView: ECWeekView, date: DateInRegion) {
//        print(#function, "date:", date.toString())
//    }
//
    // Creates the view for an event
//    func weekViewStylerECEventView(_ weekView: ECWeekView, eventContainer: CGRect, event: ECWeekViewEvent) -> UIView {
//        let eventView = UIView(frame: eventContainer)
//        eventView.layer.cornerRadius = 10
//        eventView.layer.masksToBounds = true
//
//        // Create a dictionary of classes and their colors
//        let classes = [
//            "Math": UIColor.red,
//            "6B - Art": UIColor.blue,
//            "6A - Art": UIColor.blue,
//            "Gym": UIColor.green,
//            "Music": UIColor.yellow,
//            "French": UIColor.purple,
//            "Social Studies": UIColor.orange,
//            "Planning Time": UIColor.cyan,
//            "Languages": UIColor.systemPink
//        ]
//
//
//        if let classColor = classes[event.title] {
//            print(classes)
//            eventView.backgroundColor = UIColor.clear
//            eventView.layer.borderColor = classColor.cgColor // Set border color to match background color
//            eventView.layer.borderWidth = 1.0 // Set border width to 1.0 point
//        } else {
//            eventView.backgroundColor = UIColor.gray
//        }
//    }
    
    var font: UIFont = UIFont.systemFont(ofSize: 10)
    
    var showsDateHeader: Bool = true
    
    var dateHeaderHeight: CGFloat = 12
    
    
    
    // Creates the view for an event
    func weekViewStylerECEventView(_ weekView: ECWeekView, eventContainer: CGRect, event: ECWeekViewEvent) -> UIView {
        let eventView = UIView(frame: eventContainer)
        eventView.layer.cornerRadius = 0
        eventView.layer.masksToBounds = true
        
        // Create a dictionary of classes and their colors
        let classes = [
            "Math": UIColor.red,
            "6B - Art": UIColor.blue,
            "6A - Art": UIColor.blue,
            "Gym": UIColor.green,
            "Music": UIColor.yellow,
            "French": UIColor.purple,
            "Social Studies": UIColor.orange,
            "Planning Time": UIColor.cyan,
            "Languages": UIColor.systemPink
        ]
        
        
        if let classColor = classes[event.title] {
            print(classes)
            eventView.backgroundColor = classColor.withAlphaComponent(0.25)
            eventView.layer.borderColor = classColor.withAlphaComponent(0.25).cgColor // Set border color to match background color
            eventView.layer.borderWidth = 1.0 // Set border width to 1.0 point
            
            if eventView.backgroundColor == UIColor.blue || eventView.backgroundColor == UIColor.purple {
                let labelTitle = UILabel(frame: CGRect(x: 5, y: 2, width: eventView.bounds.width - 5, height: eventView.bounds.height / 2))
                let labelSub = UILabel(frame: CGRect(x: 5, y: eventView.bounds.height / 2, width: eventView.bounds.width - 5, height: eventView.bounds.height / 2))
                labelTitle.text = event.title
                labelTitle.font = font
                labelTitle.textColor = UIColor.white // Change text color as desired
                labelTitle.textAlignment = .left
                labelTitle.numberOfLines = 0
                labelTitle.sizeToFit()
                
                labelSub.text = event.subtitle
                labelSub.font = font
                labelSub.textColor = UIColor.white // Change text color as desired
                labelSub.textAlignment = .left
                labelSub.numberOfLines = 0
                labelSub.sizeToFit()
                
                eventView.addSubview(labelTitle)
                eventView.addSubview(labelSub)
            } else {
                let labelTitle = UILabel(frame: CGRect(x: 5, y: 2, width: eventView.bounds.width - 5, height: eventView.bounds.height / 2))
                let labelSub = UILabel(frame: CGRect(x: 5, y: eventView.bounds.height / 2, width: eventView.bounds.width - 5, height: eventView.bounds.height / 2))
                labelTitle.text = event.title
                labelTitle.font = font
                labelTitle.textColor = UIColor.black // Change text color as desired
                labelTitle.textAlignment = .left
                labelTitle.numberOfLines = 0
                labelTitle.sizeToFit()
                
                labelSub.text = event.subtitle
                labelSub.font = font
                labelSub.textColor = UIColor.black // Change text color as desired
                labelSub.textAlignment = .left
                labelSub.numberOfLines = 0
                labelSub.sizeToFit()
                
                eventView.addSubview(labelTitle)
                eventView.addSubview(labelSub)
            }
        } else {
            eventView.backgroundColor = UIColor.gray
        }
        
        return eventView
    }
    
    @objc func changePasswordTapped() {
        print("button tapped")
        // Handle the login button tap here

//        // If login is successful, navigate to the "home" view controller
//        let vc = storyboard?.instantiateViewController(identifier: "changepass") as! ChangePasswordViewController
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func editScheTapped() {
        print("button tapped")
        // Handle the login button tap here
//
//        // If login is successful, navigate to the "home" view controller
//        let vc = storyboard?.instantiateViewController(identifier: "editsche") as! EditScheduleViewController
//        navigationController?.pushViewController(vc, animated: true)
    }
}
