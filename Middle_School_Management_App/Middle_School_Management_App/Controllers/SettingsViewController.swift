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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
    }
    
    func weekViewDidClickOnEvent(_ weekView: ECWeekView, event: ECWeekViewEvent, view: UIView) {
        //        eventDetailLauncher.event = event
        //        eventDetailLauncher.present()
    }
    
    func weekViewDidClickOnFreeTime(_ weekView: ECWeekView, date: DateInRegion) {
        print(#function, "date:", date.toString())
    }
    
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
}
