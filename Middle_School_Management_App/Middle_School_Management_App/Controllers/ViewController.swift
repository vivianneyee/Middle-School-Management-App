//
//  ViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivianne Yee on 2023-03-13.
//

import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

// will remove in the future and use swift object models
struct PostInfo {
    let name: String
    let date: DateComponents
    // let file:
}

struct NotifInfo {
    let name: String
    let notif: String
    let date: DateComponents
    // let file:
}

struct StuInput {
    let name: String
    let date: DateComponents
    let inputType: String
}

struct DailySche {
    let period1: String
    let period2: String
    let period3: String
    let period4: String
    let period5: String
    let period6: String
    let period7: String
}

// hardcoded data for testing, actual object will have a file field
//let eventData: [PostInfo] = [
//    PostInfo(name: "Unit 2 Test", date: DateComponents(year: 2023, month: 4, day: 18)),
//    PostInfo(name: "Unit 3 Quiz", date: DateComponents(year: 2023, month: 4, day: 22)),
//    PostInfo(name: "Guest Speaker", date: DateComponents(year: 2023, month: 5, day: 12)),
//    PostInfo(name: "Unit 3 Test", date: DateComponents(year: 2023, month: 5, day: 16))
//]

//let assignData: [PostInfo] = [
//    PostInfo(name: "Assignment 2", date: DateComponents(year: 2023, month: 4, day: 18)),
//    PostInfo(name: "Assignment 3", date: DateComponents(year: 2023, month: 4, day: 24)),
//    PostInfo(name: "Assignment 4", date: DateComponents(year: 2023, month: 5, day: 8))
//]

//let alertData: [PostInfo] = [
//    PostInfo(name: "Alert 1", date: DateComponents(year: 2023, month: 4, day: 18)),
//    PostInfo(name: "Alert 2", date: DateComponents(year: 2023, month: 4, day: 21)),
//    PostInfo(name: "Alert 3", date: DateComponents(year: 2023, month: 4, day: 26)),
//    PostInfo(name: "Alert 4", date: DateComponents(year: 2023, month: 5, day: 5))
//]

//var allNotifs: [NotifInfo] = [
//    NotifInfo(name: "6A - Art", notif: "Unit 2 Test", date: DateComponents(year: 2023, month: 4, day: 18)),
//    NotifInfo(name: "6B - Art", notif: "Unit 2 Test", date: DateComponents(year: 2023, month: 4, day: 18)),
//    NotifInfo(name: "French", notif: "Assignment 2 Due", date: DateComponents(year: 2023, month: 4, day: 19)),
//    NotifInfo(name: "Junior Girls Volleyball", notif: "Volleyball game", date: DateComponents(year: 2023, month: 4, day: 19)),
//    NotifInfo(name: "Social Studies", notif: "Unit 3 Quiz", date: DateComponents(year: 2023, month: 4, day: 21)),
//    NotifInfo(name:"Music", notif: "Guest Speaker", date: DateComponents(year: 2023, month: 4, day: 22)),
//    NotifInfo(name: "Junior Girls Volleyball", notif: "Volleyball game", date: DateComponents(year: 2023, month: 4, day: 25)),
//    NotifInfo(name:"French", notif: "Assignment 3 Due", date: DateComponents(year: 2023, month: 4, day: 27)),
//    NotifInfo(name: "Track and Field", notif: "Track meet", date: DateComponents(year: 2023, month: 5, day: 1))
//]

let studentInputData: [StuInput] = [
    StuInput(name: "Input 1", date: DateComponents(year: 2023, month: 4, day: 16), inputType: "Type 1"),
    StuInput(name: "Input 2", date: DateComponents(year: 2023, month: 4, day: 18), inputType: "Type 2"),
    StuInput(name: "Input 3", date: DateComponents(year: 2023, month: 4, day: 22), inputType: "Type 3"),
    StuInput(name: "Input 4", date: DateComponents(year: 2023, month: 5, day: 2), inputType: "Type 4")
]

// using this for capstone demo
let weeklySche: [DailySche] = [
    DailySche(period1: "Math", period2: "Art", period3: "Gym", period4: "Music", period5: "French", period6: "Social Studies", period7: "Science"),
    DailySche(period1: "Languages", period2: "Math", period3: "Science", period4: "Art", period5: "Gym", period6: "Music", period7: "French"),
    DailySche(period1: "Social Studies", period2: "Science", period3: "Gym", period4: "French", period5: "Music", period6: "Languages", period7: "Math"),
    DailySche(period1: "Music", period2: "French", period3: "Art", period4: "Languages", period5: "Science", period6: "Math", period7: "Gym"),
    DailySche(period1: "Science", period2: "Gym", period3: "Music", period4: "Math", period5: "Art", period6: "French", period7: "Languages")
]

let classColours = [
    "Math": UIColor.red,
    "Art": UIColor.blue,
    "Gym": UIColor.green,
    "Music": UIColor.yellow,
    "French": UIColor.purple,
    "Social Studies": UIColor.orange,
    "Science": UIColor.cyan,
    "Languages": UIColor.systemPink
]

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

